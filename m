Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE2E3F58EA
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 18:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784745333; cv=none; b=tJD1zfmKsKkFKW8/+tQu/smdNShol+THeqLzjFIQ/AKayAAEWrgMafULdFqGvAoArBME88f6U///mfdC7g5xe/p71eksfUtMH7+pNfvocq4j8xhPaxjVTsRVmN2BDtXgmFJDLm08OweXhYyTzLbpfQPsihSyv7jhij14Fuz80AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784745333; c=relaxed/simple;
	bh=fB5MDXjdpz5iQAHGUhY49ZSZzLO4uAvM0Zy2BponGt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mMIdhML/lL8L+oO/ZbJ1xZoG8shjB4/AetSmF3AjGn5Or7auYeVLV/eXPis2SnsHmEmljv78h08LXcr3PRRM8blYPITFym9fRRGZPOS3gXJ9rsdA9kURYAzzo40+gqPR1eenUw4HYgBWLMA04QoylP0IgEDCdm1s/qDkjHnzeE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=bBrwWqIn; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="bBrwWqIn"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8edda5d56a5so140983456d6.3
        for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 11:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784745330; x=1785350130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j2CVKVqJBHsKrJ5Bdm2nCmvoLlboB+s0FhSW+cZN6ac=;
        b=bBrwWqInU6OeYWF1kBXNFk7ws5AHXKxMjWc8gHbfW4+IRQCe86WmKd2rfv4RSfatRp
         +J78k7dLJFvBSIJDeQ0tOM3/WMwatEfRMpUG3n+pah59mayt1psWTNbkevcBpCjSa9Yv
         jtA1bh7HcuRV8eKKlVWbu3krr12yFKmQXSJl8yvxLMhHt0hmfPbmwBT4u5R3TtNf7/4s
         GO8UJPmS9HSG0XrzMUStkNsMCYJy5JZ0+nflnlBDB+A646VAOyvfocgXZezHW0jgsjbj
         JLAHRKu4JoFCaFSLYv6ychCYBVJEEYzw1BONfz1fPbkhVn2uOnKQT7sZf0O/Z48I/W1L
         uyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784745330; x=1785350130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j2CVKVqJBHsKrJ5Bdm2nCmvoLlboB+s0FhSW+cZN6ac=;
        b=e0BC9g2AfQdlfmkANLuTk3klVIQMG7+sZHCl++8aaBItWchwQ/pxLk6uV6MiU8ZSYm
         lNly6vdl3LNjs/p29ySw6+LUfwWoV2ZF0bUysb8UgwjLn1Z09TuF4PT2mHW45EmZ4yuH
         v71o8tDsdTCBeix7QiMdAxyTC1aNZ+P+MRClToyC/ROJxHCc76XOzIs47/f8LpxMIYPG
         d6WA7skRdO3Hm40+R9zWmjybrwxwPxI9laO98/jS6bi8VovumH3wYZZD3ukuyxI43XfC
         0diRInkiQhCo3Dd7EH5e6H4NpmA4nySXg5Fvp/Y0J0T/i8QVslsM4K0YQmnNWPGAZ+C7
         fBIw==
X-Gm-Message-State: AOJu0Yz9ou6gMXN/o90A4PkI+6SKi2fKE7FsdQqINjwbBs5HEVMJUuqK
	OEkRvSf7A3pbaoEP6+MPstxTj8dQm+EXrGbmODPAeHleLNfPXs0gjTaFKov834sJv2RRUHjLfJs
	r7zqt
X-Gm-Gg: AR+sD12XDJzYEaQKs+6y/HSj6nCemR2ZtUnspN6G2ndE8UH+nPvrhtwsOdosUrrMtql
	eO50sbxDzsJuqFT9W4qo5QKv8wFP2MWMaFZldCqepqJjOwqy3BtTg61+Tm5jYM22kFmbdeLTVxG
	3RyfMKQqEdudHE/X8+f1qmZajkHuQdYnG/UDdHPU4iL0ji1LVwQFpLSyZAP9psMrw3WMtTNodue
	dVUCdGveN0RnHE5vSxUPg4zGwdA4lJf4mNYznp61cyFtUmJ3KvcSJHFlunVSkOvQ10ggN21Udh2
	j8ePu/5otxfp0ZJ2lWYVfnVq5qs5QI4QW64d/EJstU/Im6Sen3RmTjPQXwLcKv4Rg5NYsFtPV23
	ZvCO6hVDVjv/szdGQMfqLxmLB7CeFutDN7QB06MuYtBNSAR+iSTMVIr6IGL4nxBuMXu3f2HUZg/
	4FpKnX+CL8GHg3icZWZ7xI/Bji+Ku86BFBLzV4tHEMzNfAxk5xUw3zlEDzYvlup8g=
X-Received: by 2002:a05:6214:5d0a:b0:8f1:579e:a41b with SMTP id 6a1803df08f44-907ca295150mr757966d6.24.1784745330173;
        Wed, 22 Jul 2026 11:35:30 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba8b3e96sm27630216d6.1.2026.07.22.11.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 11:35:29 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	djbw@kernel.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com
Subject: [RFC PATCH 4/8] dax/kmem: add the user_numa opt-in (CAP_USER_NUMA) for private nodes
Date: Wed, 22 Jul 2026 14:35:15 -0400
Message-ID: <20260722183519.935213-5-gourry@gourry.net>
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

Add the "user_numa" setting NODE_PRIVATE_CAP_USER_NUMA so userspace
may control residency on the node via mempolicy and migration.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/dax/kmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index cf6cb927e5ed5..8023db23e2f99 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -629,10 +629,12 @@ static ssize_t name##_store(struct device *dev,				\
 static DEVICE_ATTR_RW(name)
 
 KMEM_PRIVATE_CAP_ATTR(reclaim, NODE_PRIVATE_CAP_RECLAIM);
+KMEM_PRIVATE_CAP_ATTR(user_numa, NODE_PRIVATE_CAP_USER_NUMA);
 
 /* Per-service opt-ins. Visibility toggled by 'private' control */
 static struct attribute *dax_kmem_private_attrs[] = {
 	&dev_attr_reclaim.attr,
+	&dev_attr_user_numa.attr,
 	NULL,
 };
 static const struct attribute_group dax_kmem_private_group = {
-- 
2.53.0-Meta

