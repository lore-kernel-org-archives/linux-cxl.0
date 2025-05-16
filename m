Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD69B1FFC77;
	Fri, 16 May 2025 10:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747391950; cv=none; b=N3HXHCV5W5kTik8l634ZSkvli94PEa4z1SGDpGiAf/vabXY8iZ2hjWLTjW1qYT6w+RFbw+UTpaqxSZV1N/zi3I17RTflG1udc0nmGMCVQbTZdenxDKGDQaKIQuioS9Vd73J8QfbxUPSRQHR5jsB+uJwZg5dpOURhTtAsX/e0bdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747391950; c=relaxed/simple;
	bh=UKhNO8rcORbp76nd1K1WixYGB0bwzyQwNFB/e+ulAwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fKNtyr3+bdGeAP7Ady0g4Ris3NI826DYk/fBd2RE0d1FIL3IbZVtPS81FmQ43dK5pXl6k6GA4dDo8OhOvyaBTDeS4KAExingSvLPiIBKCc/MXBeuNr8FlUcN4v9i7Od+os6RtJ1hENdvISBy56dG8OJoKc+vLrRlyz344Ae91OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VlPQfKAm; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VlPQfKAm"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54G6u3jp015169;
	Fri, 16 May 2025 10:39:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=HYfYUEvVUJzf+TWW6cuOCPyPM1Hy8
	0Y9bGKKeLc+OtA=; b=VlPQfKAm7/eFdTtvvYms4jRhds6byJZFdQtlTxqvfJMZp
	L/aaANKfRuw8UjD+/+gnhiYPocpIHmEgS0kNjozMKRd8SYwtBBHE1g94bMGwY86K
	I3kkx/VwAYbK2BKCf0sb8xSm5t6bSkKjhyNFH2aaTeREoDMAwJ/Z6T1ra4Ih52PH
	gjAjKCify17L7wP27kXhydGDFpfiHNP3Rbr13MgHTDwUd2vUtvo99kTM6I5vQS2O
	5kQEYnbP8wkdelpN47xZFiXwJKKOXlNvrZP5El/1VgDGEjCTlucx/oBz3dCCwq4C
	zpmkkMWI5Wv0JOcjtEHcyzr05dbq8EA7KMwSaOGSA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46nrbf13rm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 10:39:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54G8ZE0W016194;
	Fri, 16 May 2025 10:38:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mc35xjdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 10:38:59 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54GAcxDE009423;
	Fri, 16 May 2025 10:38:59 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 46mc35xjcp-1;
	Fri, 16 May 2025 10:38:59 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: dave.jiang@intel.com, ira.weiny@intel.com, dave@stgolabs.net,
        Jonathan.Cameron@huawei.com, ming.li@zohomail.com
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, darren.kenny@oracle.com
Subject: [PATCH] cxl/Documentation: Fix typo in sysfs write_bandwidth attribute path
Date: Fri, 16 May 2025 03:38:49 -0700
Message-ID: <20250516103855.3820882-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_04,2025-05-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505160101
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=682715c4 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=wu3nt7_zq3WtXC21B0kA:9 cc=ntf awl=host:13186
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDEwMCBTYWx0ZWRfXw/Lxg/jN2SRf XsjjbIP510leRdSt+g/PIujBv5BfnVaS74xeX2QlE/110ssdHaJ5KvKB3Xxw+OBPpl0u1/+sUae NKI7/iYUeRA/2NlWsSQIfHiG9JweTFFub5lP7ZMKEbVpFH6dQUkQ+GIB+Uzxk6N5gyFM9WYZiPz
 GNOWOCR1wO8OAsBlJrdWWI8soOZan1h0MN7WeVRBCwBx5PDk1h5keLYlEouroVi8iocXzSYqfFH IQpTjWMh2FA2E4KbAtOi2ePIOd6PAyw5ZauLVWZnQeirFS5MPx8z8URIXpYPvcakkVeDc42UpKR vNOmCQCMxek970jgH99fzW9b3UwZFYrBAL63tN81UyOAK/NynA5TqFQwZuOuzaR7RFk+ziioETy
 i0i888Zi/gvMXAIw0v/nVJIHMAqYwJQvmZdISfdW2OLQ9NuvMHJQvr7LnrgGlVHdAzriYyh1
X-Proofpoint-GUID: 7UhqW4SPKfMbX9gRIVvVTidn_rDIW-zr
X-Proofpoint-ORIG-GUID: 7UhqW4SPKfMbX9gRIVvVTidn_rDIW-zr

Fix a typo in the sysfs documentation for the CXL "write_bandwidth"
attribute path. The attribute was incorrectly documented as write_banwidth.
Update it to the correct write_bandwidth to align with the actual
implementation.

Fixes: c20eaf44113e ("cxl/region: Add sysfs attribute for locality attributes of CXL regions")
Cc: stable@vger.kernel.org
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 99bb3faf7a0e..eca1054ca168 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -572,7 +572,7 @@ Description:
 
 
 What:		/sys/bus/cxl/devices/regionZ/accessY/read_bandwidth
-		/sys/bus/cxl/devices/regionZ/accessY/write_banwidth
+		/sys/bus/cxl/devices/regionZ/accessY/write_bandwidth
 Date:		Jan, 2024
 KernelVersion:	v6.9
 Contact:	linux-cxl@vger.kernel.org
-- 
2.47.1

