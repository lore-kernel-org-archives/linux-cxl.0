Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C007421D5BD;
	Thu, 27 Feb 2025 10:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740653170; cv=pass; b=i3O758Ra4VmswP/sdVJ44n8bLghYCzh+Ze1D48JJ6+plAq6/BhBZcKFmd5L6X/4sR3EI1bomZw/LuysN0z/l4XChwDMeFdOmuc6T8WUoSktpUWtEplEhPDj7dMmIi7KyeRegxSNND5YKKcHgfnHAgBy4fr33cP1WfgX9F4AwcBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740653170; c=relaxed/simple;
	bh=RXp2uaebMws9GNxExFb5p/bX6mABVj8stv4/Nt9JqqE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I49j/62Q+Vrf9XR2I3tWjeMHgVHdniSmMlgFqd7d1ifZLG/aFSPrL9Pi9MGpypZr7p9pMFHa8rm9eam3JnaiQFywx1Q7Dk6y6Xrq7tCiuSvrwlY/MKiUNrcETpjpUt1lcbmgYMqXb3TsEdGrYEXVadwV1QdEam6a3JdAzVJ6n5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=HzBrk/ch; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="HzBrk/ch"
ARC-Seal: i=1; a=rsa-sha256; t=1740653142; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QAqzH5e51QC84Asy5Gl6+jDY5aBORBuqA/YYneZYe++tHqB4ySvWRpbyVED+qn4z2uYqIq8Re2ZLdxe32tAzrqjFO07xlXaN+ZfbXy1Am8H9VIywDBL8fTqB+nnGC+ZQmKSnddZIvYFmHw8oscZyJVTT6w9Uh8+QtgqZACvlGYo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740653142; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Wq4e2lGDf1gHX1jSVAhR7jrg4z/HzsOIQlyDC5+tZVw=; 
	b=b5lWyWkHbT53yMUATnvFKjV2OqmhV43NhHwKGJCpx49IVzNfFOmM80SjLml1XZu1Puzrw7UbLQ31E4Qj/3IhDC3lQIlxBEx3OVvAWFxpZSSVFcEGNzrJj4uIo6ip6XteVvclI/mBQM8dge2k0Y1DFsTpUOh7bgbD9feiQtG4F8g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740653142;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=Wq4e2lGDf1gHX1jSVAhR7jrg4z/HzsOIQlyDC5+tZVw=;
	b=HzBrk/ch7TSIAAEK9P9IqNeuu0hbXLlCk6nlqbhFwnuJ+VTVf7fvGJ2eACP+WMeq
	AnrKCa3JpxEZUdA5qJ3scY0aRtIE8LFgUpaN5a185P4Q3NIgIJnn1ZP6+MwenvFVgS1
	eqsQELM1xit8D4dVXsqIc1VqIAL5UgGs+3AEf2K0=
Received: by mx.zohomail.com with SMTPS id 174065153918225.04211908368677;
	Thu, 27 Feb 2025 02:18:59 -0800 (PST)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v1 1/1] cxl/mem: Do not return error if CONFIG_CXL_MCE unset
Date: Thu, 27 Feb 2025 18:18:48 +0800
Message-Id: <20250227101848.388595-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122716de977bd9e00a2b5c28e18100002d32307e1d5f90d233a291772ea7b3708ac78ed75be54432b0:zu08011227ef38a246c8a88b2f526a8e4500005b3e5ae75bf88b4d49f780fc15784300101d8f7c1cd7676f21:rf0801122d33b1b5e1b2c61fe3edadcd170000391eae13e37c3bc7e9c9e8a25b36e94bcccdc3cb3223ad2b7bad279585b042:ZohoMail
X-ZohoMailClient: External

CONFIG_CXL_MCE depends on CONFIG_MEMORY_FAILURE, if
CONFIG_CXL_MCE is not set, devm_cxl_register_mce_notifier() will return
an -EOPNOTSUPP, it will cause cxl_mem_state_create() failure , and then
cxl pci device probing failed. In this case, it should not break cxl pci
device probing.

Add a checking in cxl_mem_state_create() to check if the returned value
of devm_cxl_register_mce_notifier() is -EOPNOTSUPP, if yes, just output
a warning log, do not let cxl_mem_state_create() return an error.

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
I hit this issue on my cxl_test environment with latest cxl-next. If
CONFIG_MEMORY_FAILURE is unset, all cxl pci devices will fail to probe.

...
[    6.337952] cxl_mock_mem cxl_mem.6: probe with driver cxl_mock_mem failed with error -95
[    6.338880] cxl_mock_mem cxl_mem.4: probe with driver cxl_mock_mem failed with error -95
[    6.339593] cxl_mock_mem cxl_mem.9: probe with driver cxl_mock_mem failed with error -95
[    6.340588] cxl_mock_mem cxl_mem.2: probe with driver cxl_mock_mem failed with error -95
[    6.340914] cxl_mock_mem cxl_mem.0: probe with driver cxl_mock_mem failed with error -95
[    6.345762] cxl_mock_mem cxl_rcd.10: probe with driver cxl_mock_mem failed with error -95
[    6.345793] cxl_mock_mem cxl_mem.7: probe with driver cxl_mock_mem failed with error -95
...
[    6.519824] cxl_pci 0000:c4:00.0: probe with driver cxl_pci failed with error -95
[    6.520178] cxl_pci 0000:38:00.0: probe with driver cxl_pci failed with error -95
...

base-commit: 22eea823f69ae39dc060c4027e8d1470803d2e49 cxl/next
---
 drivers/cxl/core/mbox.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 13cac98846bc..d72764056ce6 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1503,7 +1503,9 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
 
 	rc = devm_cxl_register_mce_notifier(dev, &mds->mce_notifier);
-	if (rc)
+	if (rc == -EOPNOTSUPP)
+		dev_warn(dev, "CXL MCE unsupported\n");
+	else if (rc)
 		return ERR_PTR(rc);
 
 	return mds;
-- 
2.34.1

