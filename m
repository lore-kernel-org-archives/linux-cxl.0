Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1AC189B9D
	for <linux-cxl@vger.kernel.org>; Sat,  5 Apr 2025 02:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743820745; cv=none; b=CswQuA6jwYm/eBY8935wmdISkjgGR5g5RszA/wLU78zVbUXJycuWGxlBU7kl5wvrTl0XUpGUp3Q7sOh9RlkgRZX881cV7RjSYut/tnVMzrdoLGZhAg1ny/Pr6FG9BemVDYGCJfowmZcNobrp2DYiXnoFSRvpb+y6LpAUs5FKGfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743820745; c=relaxed/simple;
	bh=YDm36M0PZoh2wJalWFye5VmTzcZORjqMjz4J3L1IT9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iONNNtSxq0T/JJ39VJAQx3RKxvPq/tKIl8OkW3QiZObyf5TGsHUJJplM63t1QwVE/l3VAJyC4ylKkBdNN2i23u86xfU2swLz31ECSTYAbU5qaXgfPnsLsTYv2BI0BlkDDsK+C7Fq3AJtxt79wKrDO/5+OtttX4jiKgEzzZDJfMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=IETT7Z8l; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="IETT7Z8l"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7be49f6b331so263230985a.1
        for <linux-cxl@vger.kernel.org>; Fri, 04 Apr 2025 19:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1743820741; x=1744425541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I7IsqKmVEgRJ8CUWYczM7gURcQ3woAE5XWEEXNva28o=;
        b=IETT7Z8l4eqtWmuoYJUD/peo38BNbTTZczqJPscvT+gUakNg5b2nDNMEpGay10zc64
         2BWRhB2FdkFeG3auOAMVfw6Zh+IB4Qsu99Mmv/qfWGIENCc3WfoZzb52mUdnHdoHz+ZB
         +CHDM8SbGB7sq6mRSFO8a5aQ59nICFI3pX9G5/YjS5hpg9LyBrv/7lO2c4UOu+5TmUH3
         N9UNJLk+rAwplY2Bbme8GcA/8julb3T0TEgrmme7T65zkydIJZy76eVAdSYUxEdbOYnB
         Ad8MQ0f5WFLpKycSqJbrzDSVB1OPU4zh+T2e70ZJNCDhDai2WLXcQbJy+rbcHzz8y+W3
         DXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743820741; x=1744425541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7IsqKmVEgRJ8CUWYczM7gURcQ3woAE5XWEEXNva28o=;
        b=c2ktnNvbER8uzixh1eR1PdHChmOBG0FeOYEGnNHUNvhnAJwzuuVhcnB4Q2rW2JNUbh
         gTmPNao+O6fscYZkClfxMxarZU/WihN94uYl2aRzPvOKxvtSVxYXutfnXz4itVXPGBkb
         Q1ePzaXYWW+SKRTPLqdrfo4nMiZ2sas4O/zq6ldnocKJgRl6Nyc8fF8TY1UPz2LjkwM3
         FSHa2/j/2Welax/v/5j35SmZk0Ih2fgVGl7lfcDY5QXW8D5qJYTNXP8W/Jnl3oF/KpXy
         YaNWxazBWUVaRgtyPSvIpJtSyZh6I8XHQafaSmG1NS2Ufuj2O7DxxhatYsRrPQWTTtDU
         ZJQA==
X-Forwarded-Encrypted: i=1; AJvYcCXQS3w+Q4eU5yZN2cQPkUeqDothG5ZKtRY7vvef2Y35rF0MkKv+HML2IEROH/XhONcjSxrzJzcvAJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe2pvv96CebfKhL99QF4U/GxfJN7v8AW3WZ65ow48pu5vBhY0f
	VIU+rClxhw0PpGxZWepRLHynDSKLWlO5wXxcNPax4/goHbc5xIAaOc9hfsJ7S3k=
X-Gm-Gg: ASbGncsV/Q6YIDAmaDe+sXCcY0KfvxzV7d426XamCQw8+Evq6F5jcOgcRR5vqhJfhm7
	0guF1xR+wkxuYImTn41SwHd1r4LhZFXQPwe00NZRv2t0VOOKKtEn2VDB5avoDZPSqArjvimYjwL
	LZjpljQz+ryz2bfOrTP3X26DXASjX6J6PNflcFyn90a0GxmqXSbguR08xj/3tPUW9q+tMMbWi2j
	jBFzghmZWmKIYZCHdvXAEojInKxwQHZCIU9/J65JYsvEXKq+Arj4UteLndhz1X7XfmbIFYjRMB5
	c7ey9LpSdGnHlwu8Ly9kPJMy8XnsLBW2h45Fz06x
X-Google-Smtp-Source: AGHT+IFnJamifOhKJVBVNrAfXybocKxTriUWdF1eOL+oFEZRHhkZ/jQC1+bclnbNTY4UiyVy2rPBOA==
X-Received: by 2002:a05:620a:1a0f:b0:7c7:5387:c754 with SMTP id af79cd13be357-7c77dd892b6mr210748585a.24.1743820741316;
        Fri, 04 Apr 2025 19:39:01 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:400::5:ba7b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c76e75ad69sm289271385a.33.2025.04.04.19.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 19:39:00 -0700 (PDT)
Date: Fri, 4 Apr 2025 22:38:58 -0400
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Terry Bowman <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH] [HACK] drop zen5_init checks due to segfault
Message-ID: <Z_CXwnILDyn3e-v0@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-15-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218132356.1809075-15-rrichter@amd.com>

Unclear why this is occuring, but a raw call to the PRM at this point
causes segfaults on my Zen5 system.  Later calls to the prm work just
fine, and modifying the structure to include pci_dev info still results
in a segfault.

Debugging this is not possible on my end since the crash happens deep in
the ACPI prm code.  Seems maybe the PRM interface isn't ready or something?

---
 drivers/cxl/core/x86/amd.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/cxl/core/x86/amd.c b/drivers/cxl/core/x86/amd.c
index 483c92c18054..5e3708f9e179 100644
--- a/drivers/cxl/core/x86/amd.c
+++ b/drivers/cxl/core/x86/amd.c
@@ -227,26 +227,9 @@ static u64 cxl_zen5_to_hpa(struct cxl_decoder *cxld, u64 hpa)

 static void cxl_zen5_init(struct cxl_port *port)
 {
-	u64 spa;
-	struct prm_cxl_dpa_spa_data data = { .out = &spa, };
-	int rc;
-
 	if (!is_zen5(port))
 		return;

-	/* Check kernel and firmware support */
-	rc = acpi_call_prm_handler(prm_cxl_dpa_spa_guid, &data);
-
-	if (rc == -EOPNOTSUPP) {
-		pr_warn_once("ACPI PRMT: PRM address translation not supported by kernel\n");
-		return;
-	}
-
-	if (rc == -ENODEV) {
-		pr_warn_once("ACPI PRMT: PRM address translation not supported by firmware\n");
-		return;
-	}
-
 	port->to_hpa = cxl_zen5_to_hpa;

 	dev_dbg(port->host_bridge, "PRM address translation enabled for %s.\n",
--
2.47.1

