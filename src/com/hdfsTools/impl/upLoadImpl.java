package com.hdfsTools.impl;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.FileUtil;
import org.apache.hadoop.fs.Path;

import com.hdfsTools.dao.upLoadDao;

public class upLoadImpl implements upLoadDao {

	/**
	 * Copy local files to a FileSystem.
	 */
	@Override
	@SuppressWarnings("finally")
	public boolean copyFiletoFs(Configuration conf, String localFile,
			String dst, boolean deleteSource) {
		File src = new File(localFile);
		String fileName = src.getName();
		Path dstFile = new Path(dst + "/" + fileName);
		boolean result = false;
		try {
			FileSystem fs = FileSystem.get(conf);// ����ļ�ϵͳʵ��
			result = FileUtil.copy(src, fs, dstFile, deleteSource, conf);
		} catch (IOException e) {
			System.out.println("成功");
		} finally {
			return result;
		}

	}

	@SuppressWarnings("finally")
	@Override
	public boolean copytoDfs(Configuration conf, File localFile, String dst,
			boolean deleteSource, String filename, int safelevel) {

		Path dstFile = new Path(dst + "/" + filename);
		System.out.println("dstFile:" + dstFile);

		boolean result = false;
		try {
			FileSystem fs = FileSystem.get(conf);
			fs.setReplication(dstFile, (short) safelevel);
			// 真正上传文件到HDFS
			Long fileSize = localFile.length();
			double totalUploadResultTime = 0.0;
			double totalDownloadResultTime = 0.0;
			
			long beginTime, endTime;
			final int TEST_COUNT = 10;
			for (int i = 0; i < TEST_COUNT; i++) {
				beginTime = System.currentTimeMillis();

				// 上传文件到hdfs
				FileUtil.copy(localFile, fs, dstFile, deleteSource,
						conf);
				endTime = System.currentTimeMillis();
				System.out.println("success " + i + "times");
				totalUploadResultTime += endTime - beginTime;
				
				//下载该文件到本地系统
				File localdst = new File("D:/hdfs/dowloadDir"+localFile.getName());
				beginTime = System.currentTimeMillis();
				FileUtil.copy(fs, dstFile, localdst, true, conf);
				endTime = System.currentTimeMillis();
				totalDownloadResultTime += endTime - beginTime;
				
			}
			result = FileUtil.copy(localFile, fs, dstFile, true,
					conf);
			double averageWritingRate = fileSize * TEST_COUNT * 1000.0 / 1024
					/ 1024 / totalUploadResultTime;
			double averageReadingRate = fileSize * TEST_COUNT * 1000.0 / 1024
					/ 1024 / totalDownloadResultTime;
			FileWriter fout;
			String output = "D:/hdfs/output";
			try {
				fout = new FileWriter(output, true);
				String contants =fileSize + "KB\t" + averageReadingRate+"MB/S "+averageWritingRate+"MB/S" + "\n";
				fout.write(contants);
				fout.flush();
				fout.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		} catch (IOException e) {
			e.printStackTrace();
			if (e != null) {
				result = false;
			}
		} finally {
			return result;
		}

	}

	@SuppressWarnings("finally")
	@Override
	public boolean fileExists(Configuration conf, String filePath) {
		boolean result = false;
		try {
			FileSystem fs = FileSystem.get(conf);
			result = fs.exists(new Path(filePath));
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			return result;
		}
	}
}
