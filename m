Received: from zg8tmtu5ljy1ljeznc42.icoremail.net (zg8tmtu5ljy1ljeznc42.icoremail.net [159.65.134.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482AB6AA7;
	Sat, 16 Nov 2024 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.65.134.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731766386; cv=none; b=A3jfPVXvdNNGdq3UH70G3Rj7ErrWA0KCG0PK9dq6usLTEDfKvDjxpmZdDNkRGqMscROaxrARQW10X/zDOZcQJuuU4b57U293AoJINd/7+XMP5RPTwiXswElHqPaPsRGjFuYidFZjSm36BHfVE/zDclKZOQgatdhJvMGgzZ9JcJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731766386; c=relaxed/simple;
	bh=sLzuW7Zo0yFb+h1NciO+AEjEEpPaMS8DkrtCpAHDBIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ucyo3gnZyj03C0th0FfAJIoEvgEw927VWcHhReSmYJoD/la4Mv5fVjDFZ1Rt7eb3/lJyLN9ejYzjm4UsnXVlO4rgYfgoLDJW4WINaerHpCYTpkDVlt4J7xV3+Lc8pLSM8Cv3YDizdQfma/NGbrzC0f7BKdL8GX8fs8yp8VoEPyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn; spf=pass smtp.mailfrom=buaa.edu.cn; dkim=fail (0-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b=TdvIwgU/ reason="key not found in DNS"; arc=none smtp.client-ip=159.65.134.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b="TdvIwgU/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=buaa.edu.cn; s=buaa; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=eRyT203gnv
	bhQv7jy5c2CPxOhVY4sEh1adauhpz4704=; b=TdvIwgU/VW2DkKVIQZHZmOSAaV
	NXWuOF/hTm+L7prQFGYgKUn+BWoVEsIvBB3Hm0eaDyp3I7omk7z97upGFBJb3nG8
	ZUfzgNiDrDLxcub+QjobtA608L9lgOuol4mB9vBAsgW2XCGMoTc4y+6Mr7mXFpGx
	fdXXjOOjdt7eq2NXw=
Received: from gp-VMware-Virtual-Platform.localdomain (unknown [223.166.12.107])
	by coremail-app2 (Coremail) with SMTP id Nyz+CgAX3gdOqDhnL0AJAQ--.21304S2;
	Sat, 16 Nov 2024 22:12:31 +0800 (CST)
From: peng guo <engguopeng@buaa.edu.cn>
To: dan.j.williams@intel.com
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	ying.huang@intel.com,
	ming4.li@intel.com,
	yaoxt.fnst@fujitsu.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wyguopeng@163.com,
	peng guo <engguopeng@buaa.edu.cn>
Subject: [RFC] cxl/region: No need to create dax devices when regions are reserved
Date: Sat, 16 Nov 2024 22:12:18 +0800
Message-ID: <20241116141218.11945-1-engguopeng@buaa.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Nyz+CgAX3gdOqDhnL0AJAQ--.21304S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1UZFWUtr4rZrWkuryrCrg_yoWrCF4Upw
	48JrWUWF4kKF12grsxt395XrWrZasavay5CrZ7C34UuanxGryjyr4rt34jq3Z5JrWDGF42
	qF1DJw4jg3yqv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9I1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
	x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
	GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY02Avz4vE
	14v_Xryl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW7tr1UJr1l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjfUO4E_DUUUU
X-CM-SenderInfo: d2isijirrujqpexdthxhgxhubq/

When adding the kernel boot command 'efi=nosoftreserve memmap=32G$34G',
the CXL memory is considered conventional memory, and the original
intention is to reserve all CXL memory using memmap, 34G is the starting
physical address of CXL memory, and the memory size is 32G. But its
resource tree is as follows, the dax device is still created for this
memory region and uses this memory as system ram.

        100000000-87effffff : System RAM
        87f000000-67ffffffff : Reserved
          880000000-67ffffffff : CXL Window 0
                880000000-107fffffff : region0
                  880000000-107fffffff : dax0.0
                        880000000-107fffffff : System RAM (kmem)

The numa node information is as follows, the CXL memory as node2, all
memory have been online:
        node 0 size: 31656 MB
        node 0 free: 29751 MB
        ...
        node 1 size: 32206 MB
        node 1 free: 29445 MB
        node 2 cpus:
        node 2 size: 32768 MB
        node 2 free: 32768 MB

When adding kernel boot command efi=nosoftreserve memmap=32G$35G reserve
CXL memory starting from 35G start address, its resource tree is as
follows, no dax device is created, and the range of reserved memory meets
expectations:

        87f000000-87fffffff : Reserved
        880000000-67ffffffff : CXL Window 0
          880000000-8bfffffff : System RAM
          8c0000000-10bfffffff : Reserved

The numa node information is as follows, Node 2 only uses 1G of unreserved
memory:
        node 0 size: 31109 MB
        node 0 free: 29364 MB
        ...
        node 1 size: 32206 MB
        node 1 free: 29736 MB
        node 2 cpus:
        node 2 size: 1007 MB
        node 2 free: 945 MB

The above shows that the memmap command is valid, but it is invalid when
all memory is reserved.

Currently, the CXL memory is only checked to see if part of it has been
already online as 'System RAM'. When all memory is reserved, no portion
of CXL memory is used as system memory, the check is pass and dax device
is created normally, the region is manged by CXL.

        if (walk_iomem_res_desc(IORES_DESC_NONE,
                        IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
                        p->res->start, p->res->end, cxlr,
                        is_system_ram) > 0)
        return 0;

Add a range check for reserved resources. If reserved resources cover the
region, skip the creation of the dax device.If the range of reserved
resources does not cover the region, part of CXL will be used as system
memory and the next check will fail.

After adding the check for reserved memory resources, the kernel boot
command 'efi=nosoftreserve memmap=32G$34G', reserve all memory, resource
tree and numa node information of CXL device as follows, node 2 does not 
exist because it is fully reserved:

        100000000-87effffff : System RAM
        87f000000-67ffffffff : Reserved
          880000000-67ffffffff : CXL Window 0
                880000000-107fffffff : region0

        node 0 size: 31365 MB
        node 0 free: 29226 MB
        ...
        node 1 size: 32206 MB
        node 1 free: 29703 MB

When the kernel startup parameter is not added or the startup parameter is
set to 'efi=nosoftreserve memmap=32G$35G',the result is the same as before
the modification.

Signed-off-by: peng guo <engguopeng@buaa.edu.cn>
---
 drivers/cxl/core/region.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index dff618c708dc..f484dfea1b0e 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3367,6 +3367,19 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, CXL);
 
+static int is_reserve_ram(struct resource *res, void *arg)
+{
+	struct cxl_region *cxlr = arg;
+	struct cxl_region_params *p = &cxlr->params;
+
+	if ((p->res->start < res->start) || (res->end < p->res->end))
+		return 0;
+
+	dev_dbg(&cxlr->dev, "%pr has Reserve RAM: %pr\n", p->res, res);
+
+	return 1;
+}
+
 static int is_system_ram(struct resource *res, void *arg)
 {
 	struct cxl_region *cxlr = arg;
@@ -3435,6 +3448,16 @@ static int cxl_region_probe(struct device *dev)
 	case CXL_DECODER_PMEM:
 		return devm_cxl_add_pmem_region(cxlr);
 	case CXL_DECODER_RAM:
+		/*
+		 * The region can not be manged by CXL if all of
+		 * it is already reserved
+		 */
+		if (walk_iomem_res_desc(IORES_DESC_RESERVED,
+					IORESOURCE_MEM,
+					p->res->start, p->res->end, cxlr,
+					is_reserve_ram) > 0)
+			return 0;
+
 		/*
 		 * The region can not be manged by CXL if any portion of
 		 * it is already online as 'System RAM'
-- 
2.43.0

