Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D694399FC
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784745327; cv=none; b=R8EBYdIjHdutGTOEclvgWKju4Kt3M8pMrADxZa6O/ekCx8717ZS0XfYJVd0Va/1JWQO+fnY5T2vdtZZz3miZ4VvF3Bm3p2bRp7LG3XWVZo8hM6F7OWCRYgmsgBe0AGgeKVYK4OBP0AIxNl91dOy2exICEP7/asZA1UrWVBIVmr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784745327; c=relaxed/simple;
	bh=dWFSG8u7oJ1tS5+bgC+LuxGSEyW5U3yv31ndL8WfbZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=skUZvbZTU2FeVwb+sA4yHXdS6281S+Vcs71mpD/lEv1xgM8su8eyTZGzQTSZGvM3WxyQTqPk7ncK3M9e1MgPQM2fUwEQF+hXHTH4GWO+SFK+k6yykbJnKFtrHSo94HdE5XYf6+9oe38m0Y2q/WnDMrkP70BFmS9GsBjbGptiJwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=cYOe7wsh; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="cYOe7wsh"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c149c5722so81149201cf.0
        for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 11:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784745325; x=1785350125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZE3yTmrW+H7J5TExci9q9j4rULKpaqgUmy/qSHf1N/c=;
        b=cYOe7wshwnGpQWgsqWmo+m+oz3PBdXOihaKRVf/Lvg134blcq7kv7uWiDeTKFqsb5a
         2kiviag2TTH0psuFpac4pUZ9dl5m4/a0GThwURMELGl5lLn7v118+xRyxxmz9Dvz+7OS
         zO8Mr01eCkvMN1d8qYXtfzVv20AovxBOMBIKO+lOyzLc/l8LE89mSecLDulx9k0SyHyx
         R+Gi/AMPdg6cQLDojhNKMX03A73G8+ilJNVT129WdlLUPiHRC4PtCNneYNkLpmyzRUGm
         ldnE0Z1fEk3Q1CtxXWFPtSBuXKU/UH/WeiIiqyFlFRcmLJwDNId1iqQOGongQhJkOwXN
         BYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784745325; x=1785350125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZE3yTmrW+H7J5TExci9q9j4rULKpaqgUmy/qSHf1N/c=;
        b=h+Stqq7y4jWgUhCmAf5ETxKOdX+G9McA8IJ18wF9Q8V2o9QHRn/h+WRZAU/eQNJkH2
         61eApB/w9Itz0tzRjdyvwtoPZLfRu0mwSoQ6rhxRgzOl0mH4m33Hmb01TFmwaFgOeRXI
         fV8PspkrXmaJ0zvufL9tKxe1bzFaJ2fUD5wHGxy/OVz1RXvU6mo4FAhGWnChUg3LFzwp
         HGW2oAcRS41JutlyvovI5MSOpJE0EdUcYX0M0onHimkS42bzajojtJZD4OfS08vV22tj
         mZ/ESpPIAHF1/n1f8cSn5WvZV1wiGNjI2A00gzChobJ/EfBz9yEhFhYEc+QKKjgzm76d
         xuHg==
X-Gm-Message-State: AOJu0Yx8NP7J63f2jVqWfL89BY9tebN8MJhgHE2w/iBB5rDId3frplzC
	jhd10sVAxBdha10XXgE8siu5Y0CipejSi8Km9waANe1gPvYRtSfl995AHtIZgbmtXh1I41ohOWK
	H44Ps
X-Gm-Gg: AR+sD11TKoJHAg9SALWHzODjlGwCh2TsKm9prQ0xMFl9S9CKgEISGptKL6xoyPrtKHY
	6pJMyG0CUCUfnQD8mtCqUtFW9J41DuPnMzHv4NrfLoGYG0Pmb/OMxC/RoiLZB3dj9U+fPODaeGr
	JmYgcanS7/4Pq97neyA3wOO2BUpKZP1FAUDhalJKP4SYkVUYZS7APzFA6SOPNTBOHIiBTCmGr/K
	5/9XN8t4MdjzI8WXjTgKoLJh4vxXIbP75Pu4Lj7mxzRLBjdbJOMhN1LL9KV3aGfXEwI59bbhYSs
	PfNQ1MTDWHRgB5p0qSSHtDDs43x2PGUHN/xZSZKSfBe76BupYZXhP3Trsnm3Aom9bhX3MHW18qA
	wItAa5o4BJmMp8+0BgRGGVKuwLl4RIBzHcHNKCEkK4VCquMivr1+xKjbxPryukKjiA3hFVnoXZ1
	gF3NToY98KsWJFZ5QfJP3/diNk1e9oAqT7IpAfsCnnjMU9VJPDAQxai4u2fAImADk=
X-Received: by 2002:a05:622a:1b8e:b0:516:35fe:5524 with SMTP id d75a77b69052e-527a5c0f064mr51449541cf.5.1784745324692;
        Wed, 22 Jul 2026 11:35:24 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba8b3e96sm27630216d6.1.2026.07.22.11.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 11:35:24 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	djbw@kernel.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com
Subject: [RFC PATCH 0/8] dax/kmem: support for private NUMA nodes
Date: Wed, 22 Jul 2026 14:35:11 -0400
Message-ID: <20260722183519.935213-1-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds uapi bits for private memory NUMA node [0] control.

It is not intended for merge - just discussion.

I have been using this to extensively test mm/ behaviors with private
nodes [1] and am wondering whether some of this is more generally
useful for coherent memory devices if private nodes lands.

For now, this is useful for testing, but locks in UAPI, so this RFC
is not intended as an intent to upstream - just sharing my testing api.
  
  Question 1: Do we want dax control of private node settings?
              1a) External? (uapi like this?)
	      1b) Internal-only? (plumbed through module apis)

  Question 2: If we do want this, do we want it in kmem or a
              separate dax driver? (dax/private_mem ?)

  Question 3: are dax_file and adistance useful regardless?

This adds 9 interfaces:

  dax0.0/dax_file
     this makes /dev/dax0.0 mmap-able when online as kmem
     it essentially attaches a default mempolicy to the vma
     that binds it to the dax device's node.

  dax0.0/private
     this switches whether hotplug sets N_MEMORY or N_MEMORY_PRIVATE

  dax0.0/adistance
     this allows overriding the default adistance to for the node
     into a specific tier.  That allows for testing tiering in both
     directions (demotion from/to the node)

  dax0.0/reclaim
  dax0.0/user_numa
  dax0.0/hotunplug
  dax0.0/demotion
  dax0.0/numa_balancing
  dax0.0/ltpin
     these bits all enable their respective NODE_PRIVATE_CAP_ bit

     reclaim   - enables reclaim on the node
     user_numa - enables mbind/mempolicy/move_pages/migrate_pages
     hotunplug - enables hotunplug to migrate memory
     demotion  - enables reclaim to demote from or to the node
     numa_balancing - allows prot_none injection on the node's folios
     ltpin     - allows longterm pin on node's folios to work

[0] private node series
https://lore.kernel.org/linux-mm/20260720193431.3841992-1-gourry@gourry.net/

[1] selftests/dax extensions for all of this that show use cases and
    testing for the private node series - including all user api's
    like mbind, set_mempolicy, move_pages, migrate_privates - as well
    as reclaim behaviors.
https://github.com/gourryinverse/linux/commits/scratch/gourry/managed_nodes/dax_private-mm-new/

Gregory Price (8):
  dax/kmem: add dax_file= to expose an anonymous-fault char device
  dax/kmem: add private= to online memory as an N_MEMORY_PRIVATE node
  dax/kmem: add the reclaim opt-in (CAP_RECLAIM) for private nodes
  dax/kmem: add the user_numa opt-in (CAP_USER_NUMA) for private nodes
  dax/kmem: add the hotunplug opt-in (CAP_HOTUNPLUG) for private nodes
  dax/kmem: add the demotion and numa_balancing opt-ins for private
    nodes
  dax/kmem: add the ltpin opt-in (CAP_LTPIN) for private nodes
  dax/kmem: add dax/adistance to make private node adistance
    configurable

 drivers/dax/kmem.c | 368 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 366 insertions(+), 2 deletions(-)

-- 
2.53.0-Meta

