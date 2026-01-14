Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC95374199
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 21:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768426618; cv=none; b=HPRJBhXUWAR7IGkYQrkdovxxcdRn502XLuv2cSeRp+wMd3Bs8K8W+pfAYPDLIv+n4bzkncgrGcN9z4rOqz+Ocj1V+ltBLmD7OSBiOlSZe2Rl4B9bNCWoJZXmXdGxgPzRQ1RaQa2YwIGVLyExQYeBJrBZghUWgNTo2VZBp/q1rSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768426618; c=relaxed/simple;
	bh=Ps/bSVqx4OehI5EayA5JYJNwyYnTQ9jqZuLjt15n6pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCLIvmPhLQdNnj/YFHcXaAhmgbvdlxEZnCHawAYR1CCUdTsE+5Jp1Kw4xuhxM8jl49vWgokMwW4Kee1mP1Ck6rQcmoT+0lY8ERQc9BGukg/F62XyjqvfNrw0zbkvNKu7PPquCMBZHtxPAR+DtEMptu+lQge3HNorMfkTJKDxcyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvgSH3Ga; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvgSH3Ga"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7ce229972f1so202933a34.3
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 13:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768426595; x=1769031395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04R2Ca8mGblkvXlxAEPOlC0zVWkPjjtROdHv+tYqk9o=;
        b=RvgSH3GaAHU1t0N1CZ5nfsOQmi7DqacwW+b69iVojbtks4RT/uFe0fvovMINkLq6OP
         KwmPKtHv5L+rm5KcAx9hK7U6PJl6C4zph04YRDo6gw7SjT+5ubbzjyKPz5MVh8BQClFp
         scDCuvzdIr+z5bJsCIu9S0Pe/UEtcFS0h7U0l0hS+gCsyRbW9RBFe2s2nDEeIMvMb/5h
         wlC1ZHiinAXy+eVrUaEPogBUpH6iif/jXrjhwMu3i4qiO16ggy3Fr8k74BgT59XNio5k
         /zO+xdiaSpAYl/EZceXXZquowJf1SJTYpr+ynLXPny+/IY6mG9adJt8zYcZpydVAEH3w
         S49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768426595; x=1769031395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=04R2Ca8mGblkvXlxAEPOlC0zVWkPjjtROdHv+tYqk9o=;
        b=HrqWskTCpAwm4ycVUU0AAPdcT7RF4fXuJlJq3O2ELxFYYWgDVdkpsjYVpyq+S2rcbc
         q5moPNCMov2cZWDN7QF9XKoDYTLPItcYr/9KdGwF3napiNqNRNZqUPUNGTc2sbEQO3N/
         RyEL12yeRipgZbyS+lOiLTXlUQfMRE0Lq/NHKr2c+0kzMiFutwVGs4TD3jHupIsmLE7i
         yXV2RRlfDlLtH+O9k9eiUHezVdLYFmvZuMEQSvcdxVy10ltzfu09cDbJAqZtqtxp+rzU
         7j1nifaGA30GXHcQdi1VFUAriH8w/C24Eqd/f3WMv5607AFD4kd245gbJpjcs/TgIQFG
         8lIA==
X-Forwarded-Encrypted: i=1; AJvYcCXDnhqsH98d9RZm96K+Roh4PqSe0+QxlZ5lbuK3QlQLEdpcp4D+5w2koJQSpOLK3qtyG3mBfhQzhGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwm2PoByh/imHmYvG0KHJ5Zqu2zlpzxdVC3pOeDdgJxOc2UVHH
	G18HrnNatDvb0bC2jFZEYrJPq8aRzRlN04qGHagu41hD6Gaxv+SprTHt
X-Gm-Gg: AY/fxX52xDUfseRe1kWjHZXY4sn1ba9O/9QI2Wt56Oe7uzTPR4/VCubxivb9qKjlZuc
	P0jZs0AEsfSeXjEUfZg1xLWBD7aZwhOiLoeC2G6uBHEqMcccVbXrNqw2obb4mN+2ubQeCuuwY0d
	zNM4NHQZAftesbTTEPoX+C7wEorOV5tPKkcgj/HG2PoMYKsqqC7nlS/txT3dBULjxpZHB/kxhJL
	f1GaxkU33gM9a1hdk3O0U0oHcwJ2H9CIWposLYpDHTxc7otyyRj/ZtWRXNBgoAVUK4u08C52Sy4
	15k8FexhuCY704khf74S8Jr7Uuoz2K6Mj2n1sM9Lz/P6hAJOHgmxQ42oqL7g2Jf9Qxf0giWYBCO
	bCpFngrMggme8RbCQ4OmXTNhY44NpEdXflD3iY00Eijsn3kbiisZIuskadbpi9wDjg3dfZSIl0L
	c1UK32Okbvyw/kYoEDFdo8ItAqnqxYGlFUpSkCW5Y+xVuv
X-Received: by 2002:a05:6808:4f1f:b0:45a:5584:9c58 with SMTP id 5614622812f47-45c73d67fd3mr2620000b6e.21.1768426595172;
        Wed, 14 Jan 2026 13:36:35 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:4c85:2962:e438:72c4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4040cba2d2asm2418156fac.5.2026.01.14.13.36.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Jan 2026 13:36:34 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	David Hildenbrand <david@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	James Morse <james.morse@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Gregory Price <gourry@gourry.net>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	venkataravis@micron.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH V4 08/19] dax: export dax_dev_get()
Date: Wed, 14 Jan 2026 15:31:55 -0600
Message-ID: <20260114213209.29453-9-john@groves.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114213209.29453-1-john@groves.net>
References: <20260114153133.29420.compound@groves.net>
 <20260114213209.29453-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

famfs needs to look up a dax_device by dev_t when resolving fmap
entries that reference character dax devices.

Signed-off-by: John Groves <john@groves.net>
---
 drivers/dax/super.c | 3 ++-
 include/linux/dax.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 00c330ef437c..d097561d78db 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -513,7 +513,7 @@ static int dax_set(struct inode *inode, void *data)
 	return 0;
 }
 
-static struct dax_device *dax_dev_get(dev_t devt)
+struct dax_device *dax_dev_get(dev_t devt)
 {
 	struct dax_device *dax_dev;
 	struct inode *inode;
@@ -536,6 +536,7 @@ static struct dax_device *dax_dev_get(dev_t devt)
 
 	return dax_dev;
 }
+EXPORT_SYMBOL_GPL(dax_dev_get);
 
 struct dax_device *alloc_dax(void *private, const struct dax_operations *ops)
 {
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 6897c5736543..1ef9b03f9671 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -55,6 +55,7 @@ struct dax_device *alloc_dax(void *private, const struct dax_operations *ops);
 void *dax_holder(struct dax_device *dax_dev);
 void put_dax(struct dax_device *dax_dev);
 void kill_dax(struct dax_device *dax_dev);
+struct dax_device *dax_dev_get(dev_t devt);
 void dax_write_cache(struct dax_device *dax_dev, bool wc);
 bool dax_write_cache_enabled(struct dax_device *dax_dev);
 bool dax_synchronous(struct dax_device *dax_dev);
-- 
2.52.0

