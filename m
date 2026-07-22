Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14814399FC
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 18:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784745331; cv=none; b=Cs73yiA5LedllK1da51eg3F2xC2gKC7uIQNASJdBTnKeIjeaqtqriFIb5HHD0oRsxbUavMahHCCaQC+h3EvtKF6Dz5MLb/y/nBP24wD+iuxvllo/TSmxKsGkbJeUXJxhhlKygg4UiYbr7TXAh62Bkqod/CMFtSrP9PHmwBoPZt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784745331; c=relaxed/simple;
	bh=vzqm4fFMouD2OMwwrdEh32Zh9IQ4/VjYNHxtQU2rRGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rhkC1TXOjP2RmoCQBpFBVcb/a4nNZ4PcCjnvZuf3BeaTEVLMg11YMo25zp8Da9+dEr+77owxU+4KNnP/hZ+QkP+/vJ0Ctq2eDpCuRqa0+W1JLWpOtgsy846y/eVtfiMOQyhSP0h99/1m+s65/LbEU2u/k43yA4PbqBX9QpuYPdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SF6Uqtwv; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SF6Uqtwv"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8ff5d1b0f91so90755566d6.2
        for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 11:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784745329; x=1785350129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V1q9zTpOIyp/zk0K72AZII9eGrDR/fzPr3ymjVJM/e8=;
        b=SF6UqtwvvPKMSHfxJ12qpbfj/TKALRNFkOx0p1KFYmhPOhj5IhD4W7mV+48Eiy2WOi
         uQwQ6kWU7nENIpSGv+eRo3SHEzJfEYC/uqzSCJLHIU1QQQh+7833mhCPPZxdx0zyeee2
         pZ+EBxEiSBzpjNW/eInfQLAR70+VLpofLXzkovFkHE0v8LtZX0vK+6iA4urE/CxII2De
         CMLzeAw111+1EF7ms465lU0GnkYEgNYM8UjC8mvv5yH4YlJu+BgD6Ch+BF/yl7mY06uj
         1e5j5mzbP9FTZpH4shdlS+cAd5CoGMU3rz3pjPoW9Vbmk1ZRoYxt2dBCVBko3Ii9BIwg
         kJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784745329; x=1785350129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V1q9zTpOIyp/zk0K72AZII9eGrDR/fzPr3ymjVJM/e8=;
        b=R1yfBc8fUiLJFH15Bo32MEGZTdw0YfnrkX9DqbmpfV1wWcMMe/L3yd2ZIZaa7payf9
         8BtHhpxsiEI0Jvv61luGUF9HcevHYyDlWHKuIGkLyK1OopTnxsAshIaMxr1+FddrUcPK
         E9QAFxDyt82XP+yGqg3bf1IzAgFx6ZVRwvaA+GfZPRnaiRaEJtmoPh8jlssq6NclY7xw
         bm8ZB/0kp3awhjjsgNCCwG5lBA4hPwKnUmvTmiw+u9biciZdZ8FFsSyPXV0O98FHVP+n
         K8r+whFwtkDsQkAk9/NqwDMBmJ+uN1183HlpLeYauAxAdkfiL+N1J4h7Qth89bCmmw0b
         BffQ==
X-Gm-Message-State: AOJu0YyHYke8lFJNpYlCvNXh7BU5YiZKg+T/rE8CnE+Tc+aKMxpcBmjb
	TlC20KbDv+x52yN1+AiGRat1LiPN/xr4JXnDaoNcD90AaudGkRsSme0pKtflM6SJ7QINQgB9gn7
	AEH77
X-Gm-Gg: AR+sD11RyW6crWyLZRkZBOvDe7onO6Z5OTWFabb+b2UsQBf2FqXq2GolZ+Q/qg+8wkG
	SlSdevKDiOwghQaKPhcwMQRifqxe21+jz54ryTqzmVLuEQpXLvxDS8RWIzuuF6vKiOUjJQ0gMBv
	QOpsmrbQnS9oMYHAde69rDXMcDdGctWJXf1P21zq9P2y4JL7A2HqwUieokTOCmihGCOKIG+le5Z
	XsnLFvNdgmSWid+pkRPnyZGQH15d7+LAsVFAJZn9VnWvLq4+CCbCfEYcbJtCsUdZPHZtNsdnufn
	2AddRrHgUA34s77SkVMxABXh4fwNcO3DcsAO85gmIHXvnre/73pDrQSqgTUFbzIY9en5tzmh5rt
	CtbnruZ8GfxSSj1IQ6ag2d+I0mEUOWQxb1gqzuktRu3j4bqDIGCfDehg6ON1YxGoo2iXZsy9EWq
	oD3RHZ2DkBZdv2JBh55c9+10eyHCpX1+R7QI6hv0ee/0L600mpH2qhOO0N4CZfz/o=
X-Received: by 2002:a05:6214:5701:b0:8f1:90f4:cb78 with SMTP id 6a1803df08f44-907ca5e95a1mr29856d6.37.1784745328921;
        Wed, 22 Jul 2026 11:35:28 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba8b3e96sm27630216d6.1.2026.07.22.11.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 11:35:28 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	djbw@kernel.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com
Subject: [RFC PATCH 3/8] dax/kmem: add the reclaim opt-in (CAP_RECLAIM) for private nodes
Date: Wed, 22 Jul 2026 14:35:14 -0400
Message-ID: <20260722183519.935213-4-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722183519.935213-1-gourry@gourry.net>
References: <20260722183519.935213-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the first per-service opt-in for a private node: "reclaim".
Also introduces the KMEM_PRIVATE_CAP_ATTR() helper for future bits.

Sets NODE_PRIVATE_CAP_RECLAIM for the device's private node.

A private kmem node opted into reclaim recovers THP compatibility.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/dax/kmem.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index c4c18aeb43c69..cf6cb927e5ed5 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -117,7 +117,7 @@ static int kmem_anon_mmap(struct file *filp, struct vm_area_struct *vma)
 	 * Without reclaim/compaction, high-order allocations can fail despite
 	 * memory still being available. Can be relaxed with reclaim support.
 	 */
-	if (data->private)
+	if (!node_allows_reclaim(data->numa_node))
 		vm_flags_set(vma, VM_NOHUGEPAGE);
 	mpol_get(data->policy);
 	kmem_vma_set_policy(vma, data->policy);
@@ -595,8 +595,44 @@ static ssize_t dax_file_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(dax_file);
 
+/* NODE_PRIVATE_CAP_* opt-in toggles - captured in data->caps */
+#define KMEM_PRIVATE_CAP_ATTR(name, CAP)				\
+static ssize_t name##_show(struct device *dev,				\
+			   struct device_attribute *attr, char *buf)	\
+{									\
+	struct dax_kmem_data *data = dev_get_drvdata(dev);		\
+									\
+	return sysfs_emit(buf, "%d\n", !!(data->caps & (CAP)));		\
+}									\
+static ssize_t name##_store(struct device *dev,				\
+			    struct device_attribute *attr,		\
+			    const char *buf, size_t len)		\
+{									\
+	struct dax_kmem_data *data = dev_get_drvdata(dev);		\
+	bool enable;							\
+	ssize_t rc;							\
+									\
+	rc = kstrtobool(buf, &enable);					\
+	if (rc)								\
+		return rc;						\
+									\
+	guard(mutex)(&data->lock);					\
+									\
+	if (data->state != DAX_KMEM_UNPLUGGED)				\
+		return -EBUSY;						\
+	if (enable)							\
+		data->caps |= (CAP);					\
+	else								\
+		data->caps &= ~(CAP);					\
+	return len;							\
+}									\
+static DEVICE_ATTR_RW(name)
+
+KMEM_PRIVATE_CAP_ATTR(reclaim, NODE_PRIVATE_CAP_RECLAIM);
+
 /* Per-service opt-ins. Visibility toggled by 'private' control */
 static struct attribute *dax_kmem_private_attrs[] = {
+	&dev_attr_reclaim.attr,
 	NULL,
 };
 static const struct attribute_group dax_kmem_private_group = {
-- 
2.53.0-Meta

