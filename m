Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7652E22A4E9;
	Tue,  3 Jun 2025 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748947439; cv=pass; b=fTYXj40i9WfEKDUckt7uA5QFkJyOqAvTh4qb5OprWxpYy1mST9kBi74IX+y1F5pCkEBMnEdLRcJpNnlA1kjVYYM0G6t88Y3dFwpU+S+sszGLqgV7waY5dRE8iJ6HDThJnZiti5GkMGL4+lKFRJryZy/u4tfU4iTfn64u2yEbI5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748947439; c=relaxed/simple;
	bh=UOPpU9PtVoNlf8/h4TdEM5+g51uv7GBYfwXIO8+hu0E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KgJwCvJihe0sriiGnGW3PBC053cmRJGfKYk/V61qKkY8p7QJ8uLwjw53/QVw2D7Gc4R/xCtnQLRrfv/uGDntElqJZrwDb08i30fsEYBqejTvm3qch40lUl+D1KTy9RIKGt9rYheSsawK+XpC7wW2ab4laLVOUgEWH4yFRmXLQkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Qf8QjXcB; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Qf8QjXcB"
ARC-Seal: i=1; a=rsa-sha256; t=1748947416; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=oBxSaNLC1ZVX4z3hNRJ7E7FioCqiyK2GB+ba5ut29OL8tKIMe7RF9prjVwczNXM9JL5SKjVPM3xU8LYVgW6o5PDlVLc0j5zRjO82BXG9R1yce/jJ5FGhjWVisXVSoSLXHfdy8Kv6FYLDMUbzPicEbpPe36NXZVywpqdSEty4lXA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1748947416; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+exrAbwaOE/nYfYixZcZUmq0Ra3xJUuqZGrJv15KDNc=; 
	b=hmDfTMjueHai8fo4v4dbWcXzcOqXxfWkEtbpXcIqgH5s6Ogc2y6kQSFb5lqOYleU9Tn9EEIM0q3ivzMandIQS5TBfZT+rBNPGEHlbNx2FdMXgz/M61CxkloaS0MpfaqikqOYf3xaNPqZZzhLIOWWfTUXtGZKhwe/ni7e19H0Mf4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1748947416;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=+exrAbwaOE/nYfYixZcZUmq0Ra3xJUuqZGrJv15KDNc=;
	b=Qf8QjXcB/Z3FN2nIWdtHtkRoKEi/hO9Kcx3yIzSyLjmoxzHUCEtf40n2Sv4FZqBh
	Qcr+wEUJLHLuGGEP9HjG5dGBItZoaaAgptsW+MVCNn9V26A9xzpPafviyUFqS17ZtxW
	X5KNclILpW50ipHl0W/DFl2SNNbL9b0gFOtYHzBk=
Received: by mx.zohomail.com with SMTPS id 1748947414702215.9298254933907;
	Tue, 3 Jun 2025 03:43:34 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	shiju.jose@huawei.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v1 2/2] cxl/Documentation: Add more description about min/max scrub cycle
Date: Tue,  3 Jun 2025 18:43:14 +0800
Message-Id: <20250603104314.25569-2-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250603104314.25569-1-ming.li@zohomail.com>
References: <20250603104314.25569-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227bf11e911764d7ca8af0e472a0000a00d86b2da1806a641814e632fc45fd9517aa7dadc5e5df11d:zu080112278ebcf9b3e03d6d7da4c815a2000027f198bbd17bc3f643fc4154c22c0178ff91302ae14c55ca98:rf0801122df57fce9e89c6394adac411c500009ec9410f457a08fa81dfd932178ca11a315212bcc71c08eeec02c3546ccffc:ZohoMail
X-ZohoMailClient: External

user can configurare scrub cycle for a region or a memory device via
sysfs interface. Currently, these interfaces have not enough description
for the return value. So adding return value description to these
interfaces.

Suggested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 Documentation/ABI/testing/sysfs-edac-scrub | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-edac-scrub b/Documentation/ABI/testing/sysfs-edac-scrub
index c43be90deab4..ab6014743da5 100644
--- a/Documentation/ABI/testing/sysfs-edac-scrub
+++ b/Documentation/ABI/testing/sysfs-edac-scrub
@@ -49,6 +49,12 @@ Description:
 		(RO) Supported minimum scrub cycle duration in seconds
 		by the memory scrubber.
 
+		Device-based scrub: returns the minimum scrub cycle
+		supported by the memory device.
+
+		Region-based scrub: returns the max of minimum scrub cycles
+		supported by individual memory devices that back the region.
+
 What:		/sys/bus/edac/devices/<dev-name>/scrubX/max_cycle_duration
 Date:		March 2025
 KernelVersion:	6.15
@@ -57,6 +63,16 @@ Description:
 		(RO) Supported maximum scrub cycle duration in seconds
 		by the memory scrubber.
 
+		Device-based scrub: returns the maximum scrub cycle supported
+		by the memory device.
+
+		Region-based scrub: returns the min of maximum scrub cycles
+		supported by individual memory devices that back the region.
+
+		If the memory device does not provide maximum scrub cycle
+		information, return the maximum supported value of the scrub
+		cycle field.
+
 What:		/sys/bus/edac/devices/<dev-name>/scrubX/current_cycle_duration
 Date:		March 2025
 KernelVersion:	6.15
-- 
2.34.1

