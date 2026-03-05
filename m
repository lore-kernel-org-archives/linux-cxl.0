Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA0E2D9492
	for <linux-cxl@vger.kernel.org>; Thu,  5 Mar 2026 20:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772743267; cv=none; b=b8to7kUCTizFxwUqt+RrlTUVywoxYY5onZWraqn8wB9vVLkqZK1zBTqtWNlk55nD4A53HrchuhyZBOTmIPP1M+DQ1/zb3CpCyUBhyzfHjFxzvDN4S8msuNI2BROBGlvR5pn3hNmxI9mYA4m1krvFODP5C+Q4WFH38gltq6xz0Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772743267; c=relaxed/simple;
	bh=zPJ3Y+yDea4Wipn9C7hVTDWutpEoY3T1kNCWYcK5fnI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cQtT0DaGJObLWACAG3RHAMfZuLKVeQPCRVJSy5XIXTdedVnpF4L/ZPae6Ugj6VmsHkMVHdYifctKsgAEqY6F/CIE7OGOo+4ybRH9R8+Tcc+LZ2WPFTPhSacGydTcD+4x3I1HDqJOAcpESczBTaWfOvsXvHHeD2C5xfJFdXWoWYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=tHfVR7Vl; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="tHfVR7Vl"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625IrgKx2783611
	for <linux-cxl@vger.kernel.org>; Thu, 5 Mar 2026 12:41:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=pz1kGaQ8Rwu3t2Xr6B
	++kDioKlYvqvC5AOXYPIE8zFo=; b=tHfVR7VlTCZ0MsT9aj/wDhNyM4LRBWMb9K
	R/6jdSwJrib8kleRnT62/YGVM0j5JRB4ebezij8RIJhJXR3xQAsmTrrx87Xv+WQk
	oLoAaWvxuNq7Ra6AMWy9chECklXZ6iZOTF1h9GyIw0TlA0Q6sVfU5bf/HTP5/+X0
	vnPLCc2CH/TKK/RndO0naoX4vUKaUeABCEyo8v0gJFaYtNdskO2w4H00IetqKvXh
	KP1k4Tm3b4vP1UIWB2VIlG4I6t8fUkG3G7F8WXFXKI6gDrliF9oaV2rUBZ9z3/a4
	tblp77iWUgwwUUnLBvELxWjHvpCrw3pvagIjyJn9k6aW4Wu3jKug==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4cq5ew075n-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Thu, 05 Mar 2026 12:41:04 -0800 (PST)
Received: from twshared26141.04.snb1.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 5 Mar 2026 20:41:03 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 6358E9EBB747; Thu,  5 Mar 2026 12:40:57 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <dave.jiang@intel.com>, <gourry@gourry.net>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH] cxl/acpi: Fix CXL_ACPI and CXL_PMEM Kconfig tristate mismatch
Date: Thu, 5 Mar 2026 12:40:56 -0800
Message-ID: <20260305204057.1516948-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: y2CTI8HYy3vfa3hTnHOJWkgwjEoVVYEN
X-Authority-Analysis: v=2.4 cv=PMECOPqC c=1 sm=1 tr=0 ts=69a9ea60 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=crHB47gyY4rKiduisYu9:22 a=VwQbUJbxAAAA:8 a=gKdFwzJss0udLLItagAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE3NCBTYWx0ZWRfX/DBID4pm33Ow
 kg78Lbg4R1H0uajuajB2Pg2FOAczmtd2gxLAmGGDzYrUnE3snuJ+X+/zy95yLYVrwm1k8oJI8m0
 2KHm4Y4PtgGqMAiLC/0fIET7VK6SDADbovXfQmjCGoF3MqsBhGB9lI1e60ajRXJpAXhzfep8Ry/
 /MFCLHtzLAOdJlzhTuboPMrVfsIkvZeb3RIeHyTqvniuNU7HEF86dult3tCFdQukegyW58bglJO
 KOpZr2bDVQHM8wYTJKFqoGbhKf7EWUKUfWIxdSK3rfJ2F0qa5cmgdQ/jElTMlpktSDSiJpdrdQ1
 5OAGRBPGsS/7U/CkUIQ5VZY7mdvFOpymi0rExspMaFIeUax+yexUeK2ICVjdahA+xy9L4bg/11y
 oBugyPuKBDSjZYfVJox3PUkCteEUIGqYi1skLVskN3YqGlf7C/iTfh1KOAE8RcNlbooEuY6WwsY
 yhB/oL8iejqnVR3xBQw==
X-Proofpoint-ORIG-GUID: y2CTI8HYy3vfa3hTnHOJWkgwjEoVVYEN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_06,2026-03-04_01,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Commit e7e222ad73d9 moves devm_cxl_add_nvdimm_bridge() into the cxl_pmem
file, which has independent config compile options for built-in or
module. The call from cxl_acpi_probe() is guarded by
IS_ENABLED(CONFIG_CXL_PMEM), which evaluates to true for both =3Dy and =3D=
m.

When CONFIG_CXL_PMEM=3Dm, a built-in cxl_acpi attempts to reference a
symbol exported by a module, which fails to link. CXL_PMEM cannot simply
be promoted to =3Dy in this configuration because it depends on LIBNVDIMM=
,
which may itself be =3Dm.

Add a Kconfig dependency to prevent CXL_ACPI from being built-in when
CXL_PMEM is a module. This contrains CXL_ACPI to =3Dm when CXL_PMEM=3Dm,
while still allowing CXL_ACPI to be freely configured when CXL_PMEM is
either built-in or disabled.

Fixes: e7e222ad73d9 ("cxl: Move devm_cxl_add_nvdimm_bridge() to cxl_pmem.=
ko")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/cxl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 4589bf11d3fe0..80aeb0d556bd7 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -59,6 +59,7 @@ config CXL_ACPI
 	tristate "CXL ACPI: Platform Support"
 	depends on ACPI
 	depends on ACPI_NUMA
+	depends on CXL_PMEM || !CXL_PMEM
 	default CXL_BUS
 	select ACPI_TABLE_LIB
 	select ACPI_HMAT
--=20
2.47.3

