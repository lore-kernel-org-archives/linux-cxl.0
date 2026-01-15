Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9840253B73
	for <linux-cxl@vger.kernel.org>; Thu, 15 Jan 2026 02:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768444982; cv=none; b=qjD0jRUe6qDn4zfcN9/PcSWiNJ725vHzKU6/n7ENg0twWePEHqqPjPLI0xNpxasFfodtnQHBywq4o1xUiVrmtZf3pP7RkR9/+XLWsCp8ufWw+bnoy+waP5acieQyIHbUkf7InLJJeucG2VEtp2fseFpRsNj5pM3s2LKvkaAQEc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768444982; c=relaxed/simple;
	bh=fDcOEzdBe5xRENpKlXhSuHOhCSlbP++yhs6h6KsFKQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qfd+fFkuCVop8L9AEFcnbuH5hIxItLU4GqH3iSW+AziX8wroXZu2dA9WbJVn3cHEV3nUFMfT5b6eyXVpoSYEC+GK7XvcqSxzhVv28kqyMvM3Xu+JRGCtLSkHgtQG7cZc0xyH7AS6P6nPazFGInjPpMcAeJ8pzJBtFJ4GdyButJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Us9t87d/; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Us9t87d/"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-501488a12cbso4562941cf.3
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 18:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768444980; x=1769049780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcW/hY6JWQg4aPWEmrNXUmJDtQucQInwfAPavQZW27U=;
        b=Us9t87d/dhJEqXczgG1WsOAfkTeSyLmXACYX/1WdL3flk9o/yhwqBfeotEvTE9SDbN
         v7g4s7P1Jamensj/GW1tCYt0ZWoP84t3/hlvPDpdGxI2Obwgd/M9nBIIdMK2K16DRqrf
         utAll/OhHARLVpSRdHoN/WQq/3Dhq12kfNiFB/6x3+GLCFKE8Gqc2KeDsga7Lq+a8U5Z
         WLeMfgTnCbNyBxxub+fc2wZei8Op12Y8m13/MM1coamo6MGcl2kM3bh0pAU5vpUiQiN3
         zGYOXqxXEF49tK749g+92sfXJ73JBE7WXD15srYy+35Vgz7/c3JaKIDGcz00XkV/jJMH
         PR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768444980; x=1769049780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qcW/hY6JWQg4aPWEmrNXUmJDtQucQInwfAPavQZW27U=;
        b=fidVmZgFDuH/TlZrTFJcFNv5j1/XDAux+95y3RzuFZfiO36u5dfBZTy+nTio9tunrn
         EGRD4nS7lxg9t3G0kkDeGH9kvVGxvII0runBeO3n/K9wv7rZY6MPDMP2kw5riOwAJGto
         /HMe2HP9XVpyIC6IDYSwlr4SBmhHQ5F/TMXDZg0DDhGHWNQBxysgUB8/8lJIetA0dXpU
         tTZ/v/8sX7Fl0DA/D/F5Cq8RhNAosZQTiZ893WnH683SttKIG5jyztIxWhtJ0r4e5Xwd
         hPGPqvn1QC1PxinDfy7ZJ/ljnoo82qXCzG753oCC/5AVcm+5s4zbdw7oVYF5zTB29B3g
         fpFQ==
X-Gm-Message-State: AOJu0Ywnr+bWMnxn77rgewDMxJ1QtfyNngWlrI4U9BOKNzucjcCkT12D
	PlLm2gA8IZR52uzSLzzqL3srxc2TcZYF9AYsohUCHJL0jbprlwFs82DqMS55k0vm60o=
X-Gm-Gg: AY/fxX7UEClQ6+pduc1lYf9CJWZ92X+QCg5fei6P59vRK6W6ZVoLqcZd210Ranta9IA
	mSkVgm7Zl0tidvJbgec4jd9M2xg88G6O7Ij6zrdKNoQMeKW9DZAPTHpFF19rS4SP2yXFKieN0Tz
	48Il1hfwqlAHAFTQqDfhl43wSFcmuCbUNy+XODxa7HouPzhuwITZOnQXHHAD2dm2BXtIaiPhhj4
	bzvxVJQAdS6ij7VA/eZe1KimLWLnyGYAsXHiNqztQdbTI7x9ZtHsv7fBUEA2npc85fKGdD/MYiw
	/z5xQZ/mzjlaAHYoxZvGnzef7sHnQ18bbTNqX6glYGqM2+kZEUupC/CsAvxAhqpyNY3rNi8Coom
	ptn23h7MIZKzHjAgKn20vbb0bnb6EEOJZTQBuRGywNMHCbhJzPic1XT5/kkxgeu+tHIDvLKwbsN
	1ia2HMnvSl5RTEwOgRIhlYwJyi3omEKpYp6fCO2nBbSEjv4qE5B0bOToGJRL8z0gBQWBn0N5GSy
	D0=
X-Received: by 2002:a05:622a:1f11:b0:4ee:4a3a:bd05 with SMTP id d75a77b69052e-5014849d291mr69984841cf.74.1768444979611;
        Wed, 14 Jan 2026 18:42:59 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50148ee050esm26853761cf.30.2026.01.14.18.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 18:42:59 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	kernel-team@meta.com,
	dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	david@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	osalvador@suse.de,
	akpm@linux-foundation.org
Subject: [PATCH] dax/kmem: add build config for protected dax memory blocks
Date: Wed, 14 Jan 2026 21:42:22 -0500
Message-ID: <20260115024222.3486455-1-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114235022.3437787-6-gourry@gourry.net>
References: <20260114235022.3437787-6-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since this protection may break userspace tools, it should
be an opt-in until those tools have time to update to the
new daxN.M/hotplug interface instead of memory blocks.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/dax/Kconfig | 18 ++++++++++++++++++
 drivers/dax/kmem.c  | 29 ++++++++++++++++++++---------
 2 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
index d656e4c0eb84..cc13c22eb8f8 100644
--- a/drivers/dax/Kconfig
+++ b/drivers/dax/Kconfig
@@ -78,4 +78,22 @@ config DEV_DAX_KMEM
 
 	  Say N if unsure.
 
+config DEV_DAX_KMEM_PROTECTED
+	bool "Protect DAX_KMEM memory blocks being changed"
+	depends on DEV_DAX_KMEM
+	default n
+	help
+	  Prevents actions from outside the KMEM DAX driver from changing
+	  DAX KMEM memory block states. For example, the memory block
+	  sysfs functions (online, state) will return -EBUSY, and normal
+	  calls to memory_hotplug functions from other drivers and kernel
+	  sources will fail.
+
+	  This may break existing memory block management patterns that
+	  depend on offlining DAX KMEM blocks from userland before unbinding
+	  the driver.  Use this only if your tools have been updated to use
+	  the daxN.M/hotplug interface.
+
+	  Say N if unsure.
+
 endif
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index f3562f65376c..094b8a51099e 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -184,6 +184,21 @@ static int dax_kmem_memory_notifier_cb(struct notifier_block *nb,
 	return NOTIFY_BAD;
 }
 
+static int dax_kmem_register_notifier(struct dax_kmem_data *data)
+{
+	if (!IS_ENABLED(DEV_DAX_KMEM_PROTECTED))
+		return 0;
+	data->mem_nb.notifier_call = dax_kmem_memory_notifier_cb;
+	return register_memory_notifier(&data->mem_nb);
+}
+
+static void dax_kmem_unregister_notifier(struct dax_kmem_data *data)
+{
+	if (!IS_ENABLED(DEV_DAX_KMEM_PROTECTED))
+		return;
+	unregister_memory_notifier(&data->mem_nb);
+}
+
 /**
  * dax_kmem_do_hotplug - hotplug memory for dax kmem device
  * @dev_dax: the dev_dax instance
@@ -563,13 +578,9 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	if (rc < 0)
 		goto err_resources;
 
-	/* Register memory notifier to block external operations */
-	data->mem_nb.notifier_call = dax_kmem_memory_notifier_cb;
-	rc = register_memory_notifier(&data->mem_nb);
-	if (rc) {
-		dev_warn(dev, "failed to register memory notifier\n");
+	rc = dax_kmem_register_notifier(data);
+	if (rc)
 		goto err_notifier;
-	}
 
 	/*
 	 * Hotplug using the system default policy - this preserves backwards
@@ -595,7 +606,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	return 0;
 
 err_hotplug:
-	unregister_memory_notifier(&data->mem_nb);
+	dax_kmem_unregister_notifier(data);
 err_notifier:
 	dax_kmem_cleanup_resources(dev_dax, data);
 err_resources:
@@ -619,7 +630,7 @@ static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
 
 	device_remove_file(dev, &dev_attr_hotplug);
 	dax_kmem_cleanup_resources(dev_dax, data);
-	unregister_memory_notifier(&data->mem_nb);
+	dax_kmem_unregister_notifier(data);
 	memory_group_unregister(data->mgid);
 	kfree(data->res_name);
 	kfree(data);
@@ -640,7 +651,7 @@ static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
 	struct dax_kmem_data *data = dev_get_drvdata(dev);
 
 	device_remove_file(dev, &dev_attr_hotplug);
-	unregister_memory_notifier(&data->mem_nb);
+	dax_kmem_unregister_notifier(data);
 
 	/*
 	 * Without hotremove purposely leak the request_mem_region() for the
-- 
2.52.0

