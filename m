Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345D9205AA5;
	Thu, 13 Feb 2025 06:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739428853; cv=none; b=hFAI3aPBjs1sCrS55zSwoiF+css7mz/oTCBOegWZXqZtSH6gMe9b5fEFM2gbbzoVmfA4IVL3F21jU3TTeWA8Qgehs1FKtXnTupH2A9n1tLVVe+uNmWVKScvpLwByFV8bmzdsAszC++PpOb3FuoXGY1BCiSS35zIesmAg+TogicU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739428853; c=relaxed/simple;
	bh=Idvire8JfLNlg/t/DxUmbh1QufF3qrKQ4pmGzadBvb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pMoog8EF6Hnkk59P8rFDOxQXG8JoLIndhCZEtx9yDZv4XeJ1duXtz1MIQMfAzat8vNxprud67K8LJ5z3yR5X4SAnp8wS4dPIUbezo4IuA3iiwqz2bEowvqx2mdz6fNvrELVdesF8z3ivA/WiIglMZWCa40rOllg6M9NkDulf9To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwBHTibjk61nT76aAg--.63767S2;
	Thu, 13 Feb 2025 14:40:35 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwDHyYXbk61ngoElAA--.9652S4;
	Thu, 13 Feb 2025 14:40:32 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [PATCH 1/1] cxl/pmem: debug invalid serial number data
Date: Thu, 13 Feb 2025 14:40:08 +0800
Message-Id: <20250213064008.4032730-2-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213064008.4032730-1-wangyuquan1236@phytium.com.cn>
References: <20250213064008.4032730-1-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwDHyYXbk61ngoElAA--.9652S4
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAAAWes-icCNgABsn
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWrtw13tr48JF4rKF1kJr1fWFg_yoWDuFg_KF
	4DuFyfWFyUGF13KF13Kr4fAr95Ar48XF10qrn8t34fJ39rAFZxuryvvrnFvry09rW8KFnY
	qrnFqr1fZrn2gjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
	Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
	UUUU=

In a nvdimm interleave-set each device with an invalid or zero
serial number may cause pmem region initialization to fail, but in
cxl case such device could still set cookies of nd_interleave_set
and create a nvdimm pmem region.

This adds the validation of serial number in cxl pmem region creation.
The event of no serial number would cause to fail to set the cookie
and pmem region.

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
---
 drivers/cxl/pmem.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index f9c95996e937..89f4eac49313 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -384,6 +384,13 @@ static int cxl_pmem_region_probe(struct device *dev)
 		};
 		info[i].offset = m->start;
 		info[i].serial = cxlds->serial;
+
+		if (info[i].serial == 0) {
+			dev_dbg(dev, "%s: invalid serial number\n",
+				dev_name(&cxlmd->dev));
+			rc = -ENXIO;
+			goto out_nvd;
+		}
 	}
 	ndr_desc.num_mappings = cxlr_pmem->nr_mappings;
 	ndr_desc.mapping = mappings;
-- 
2.34.1

