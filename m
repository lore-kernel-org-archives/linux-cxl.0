Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E523E2ACD
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 21:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779224528; cv=none; b=pELoX4ZkHywH4Q54awFN1++IZ8y9dEuMiJ5B751/Iwz+JqwuhN3k4GeY75W98AJlJN1+GNpb3Our+HhYc3dJc26zTIoAJLdDbHJ+NWs1qha249gEUh4l29UPZN+GOMPfOnorOYzNoZs64oOzFg5qWp9f1kiqqvT2Le/9pfKNiNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779224528; c=relaxed/simple;
	bh=JYeAa6sKeGAtqiLdKq9snw73LNYWCXBLpso0TugKQg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZmHIvEjKBcjDQKCTyLqJgJ7f+w0GlzxhAtQ1lqMn0dunmx4qw0uhPdoHZ8uFYQM4ShHoydTejX1Tx+LguN287JEO37z6lteVqXpkq9msH3zz0xCBbPR45vyaTpl9sBC5t/oXKPbwcX7xgi8THacMIVT0wSqzjF9QJfO167iuBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gI02aRAt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gI02aRAt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929A31F00894;
	Tue, 19 May 2026 21:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779224526;
	bh=TplX7dxnLMWOibybV8kYp4n2M8CdJVzHW2MT+RxFb70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gI02aRAt6jkiRGGoCx4X8RMDl+Vch7RXUbxt4iRYxXff7nUQvwjiNepC0MhcUblS2
	 COzsgPdGYZJnVkwnZ4vuNgSfuogrSvCcrrT97xeera9zZT+U2UCSq+JC4tPD0PWsgb
	 Z7yEUOXjEkTRDhyt2QQEFFlHkDJ3IGVLZoyS7EMRyGRVAG91jeFh8n8pS9zoSI2tir
	 JcJdXvbhiY+JrPQPXbXbDdiT9DAzfYSZ1sJ/AVK7Vv/lXHPC5DvudysklpazHGegRp
	 kuwZhNqoqxT9Ogae8plXBo9+xuZbvrBVZ/IfSLLrsusYiDjlqfURJxZoPqc6j7JsCI
	 1j7fsURD5VDpg==
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id F2E2CF40075;
	Tue, 19 May 2026 17:02:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 19 May 2026 17:02:05 -0400
X-ME-Sender: <xms:zc8MaqgJQP8RKD6wiXfD4RAPEKskARaRfJa_f1N5s-mhnH-Cg-2UVA>
    <xme:zc8Mah7z_egZpKRyS9zEjpRkDAOPq6-tsaUWLaBpUt71GsNeNNWbEfKm9-UNdsGgE
    KtdJoct3qeO6MdmLQbQBrvHsHRIyCggbZby6W_uYVmIB4-uxReOM5Y>
X-ME-Received: <xmr:zc8MaqYKSCMPR5_xTmV4SQWom2oT67EbH5ImyWNHo9TSuqgcOyn5ECvHIUGgMBYA0hKJV0OITm68zrAL-yLjwEnl69InPVW504g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedvjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeffrghnucghihhllhhirghmshcuoegujhgsfieskhgvrhhnvghl
    rdhorhhgqeenucggtffrrghtthgvrhhnpeeuheffhfelleelgedutdfhleefjeejvedtke
    fgjeefgfettdeljeefvefhueeiveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpegujhgsfidomhgvshhmthhprghuthhhphgvrhhsohhnrghlih
    hthidqudejjedvfedtgeehhedqfeeffeelgedtgeejqdgujhgsfieppehkvghrnhgvlhdr
    ohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgtgihlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepuggrvhgvrdhjihgrnhhgsehinhhtvghlrdgtohhmpdhrtg
    hpthhtoheprghlvghjrghnughrohdrlhhutggvrhhoqdhprghlrghusegrmhgurdgtohhm
    pdhrtghpthhtohepjhhitgdvfeeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughjsg
    ifsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zc8Mau7W5glmCXeQwhX5G-Ivieirh84hvTjkqaB7-QeOt52-VSzIQg>
    <xmx:zc8MalAU4VhdJIwDg4HsIwI1GrYsNVcZmEXjMZtTb4eDR-AXPI4Zcw>
    <xmx:zc8Masff0S00QPZt6_Jv5Cm3CO9Lrl4WryTv7SbbYLL2w-IDlbyN8A>
    <xmx:zc8MasJZFkU2nX8b4lZ1aABsq2TI5FPZ1vbMN_v91hcBpXFzaPT_Kg>
    <xmx:zc8Mav3EcXHhshBlhbXu6SNrkmtiQQQgOGLLomkd22lLpWD2Od9bBeNH>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 17:02:05 -0400 (EDT)
From: Dan Williams <djbw@kernel.org>
To: linux-cxl@vger.kernel.org
Cc: dave.jiang@intel.com,
	alejandro.lucero-palau@amd.com,
	jic23@kernel.org
Subject: [PATCH 3/5] cxl/memdev: Pin parents for entire memdev lifetime
Date: Tue, 19 May 2026 14:01:56 -0700
Message-ID: <20260519210158.1499795-4-djbw@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519210158.1499795-1-djbw@kernel.org>
References: <20260519210158.1499795-1-djbw@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to be able to manage the driver that uses a memdev attach
mechanism the parent needs to stick around for the
device_release_driver(cxlmd->dev.parent) event.

Fixes: 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation")
Signed-off-by: Dan Williams <djbw@kernel.org>
---
 drivers/cxl/core/memdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 80e65690eb77..91c99eeea92c 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -25,9 +25,11 @@ static DEFINE_IDA(cxl_memdev_ida);
 static void cxl_memdev_release(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct device *parent = dev->parent;
 
 	ida_free(&cxl_memdev_ida, cxlmd->id);
 	kfree(cxlmd);
+	put_device(parent);
 }
 
 static char *cxl_memdev_devnode(const struct device *dev, umode_t *mode, kuid_t *uid,
@@ -707,7 +709,7 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 	dev = &cxlmd->dev;
 	device_initialize(dev);
 	lockdep_set_class(&dev->mutex, &cxl_memdev_key);
-	dev->parent = cxlds->dev;
+	dev->parent = get_device(cxlds->dev);
 	dev->bus = &cxl_bus_type;
 	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
 	dev->type = &cxl_memdev_type;
-- 
2.53.0

