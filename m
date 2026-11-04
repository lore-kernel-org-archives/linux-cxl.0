Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833400;
	b=1w7ICQLFbXfRNntU/upm9KlMv1YJQ3NiF8bqa6hSezBUXdAFLpzOQewW7ZToOB5ZeifI
	 aFHva6V8ShSXnCJjJ499lTLeYJxIp9jFODgXo6bbxFcgco8FKfQOgRHLe8Zy3tX/34FRC
	 STtQq1ZngV555iWVljrN8VGkGuE/HtMuUe57nVf3m9hPL8qy7BJGA0oaoZK07t6RbXijD
	 2PCcnQsDO/WkQV+COSmSHHn/A7T9oO4FMew6VkgcHmdADWqWruyJtZe0KS7KlcxQBKQGW
	 kdDf/Ubu+W0OROvKtrlIy0POE6cmctzRurxw4wc2LMNIs3GQwxLlbBWSObZxugsvzQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833400;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JjVmyA1Ji2mgmJW2bGoabu/LnrHT9uPLyqNSgz4ATc0=;
	b=vYTJ7ve/LW83auUxN5AaGrQKc5ia6DMnf5yIyeTNCyiQsd6PH8EEikaXwK0ohI/f4AnX
	 ajynTHZZTJFIe2z/VdN4xdRuLwslrJhVVC3oqAa3nSPkQgj9hcmA9SWcvGmjecX4hKUu8
	 EcxxqyyA4LSnx/QFXpBwIak38FZEBmkNL2KMgEyVWjOC7dYjYNKACDgpYE5vPeJWfE1pV
	 TuSYSxfzZOZJFiv09t2n1O0ZDcmMPoG7QTkC6BfqMxi6Q8p6qCLD0YtddSpqKEMdQs/pm
	 sv+TGeseXGein0/UzTjosg0htTeiaLQch1hIS7DJYMl36YqOgy5cwTVMnqKLbU/1okw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YTHwVtp3;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD63D606D807
	for <linux-cxl@vger.kernel.org>; Wed,  4 Nov 2026 23:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD63D606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YTHwVtp3
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e9995ce866so9959335ad.0
        for <linux-cxl@vger.kernel.org>; Wed, 04 Nov 2026 15:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793833399; x=1794438199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JjVmyA1Ji2mgmJW2bGoabu/LnrHT9uPLyqNSgz4ATc0=;
        b=YTHwVtp3HcTTbYZGmVwguYhptTySymk2skr5vQ8mCgqtt/Yocm8BkN2ykxgqxNr90g
         Xk9Bjwr+ZdaLsC12dvrkzhG5Drtd34+CdQ7EcDS8SqP+LZ81we9S44ihWiF9rEFDst65
         0t04Z1RdsD+l9WOXa69zRYHufUs1+hPYniR7Ov1D3Y43ZKO/XdkwfEcEueMKVtXArW/3
         lbbiisC8yxqzdHotQ9jxtHAani/bkmDAhm6Xy/KH8BiivtQTWG35L+XxDkJj4760mONK
         OJlwdFxnGTpNXJ8EB9dJdGowBrRYc9WVNDEIp2Ymr6hGOAeHeacxbOO09Vuw+obSKb/O
         62Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793833399; x=1794438199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JjVmyA1Ji2mgmJW2bGoabu/LnrHT9uPLyqNSgz4ATc0=;
        b=D7LtYDsuSEQb+pOd5sWWhQ05R3FjheBlPcFj1c4/9V6NxYW3UIs1duFBJlB2mWBu8i
         K0L+KBmUld/V+lTIB0f1yZBbHu3Hny75U0QcmDbBiJHj53btpZrGhYOsZO0sREWiEjAY
         0qcA+Whosjw7lv/wEi3TTyo8qOjjhFyFGhTZy/1/1s86zcZQYAlI6NN2eREYPDNcUyxg
         abeZT6U7rcJJ4buivz2q8GEqz1VXPxEFEeRcJ55CaSh8FNFO/l5ATdNWzocjDfHJQY2j
         xlU64dJk2ohpaMXxQ0CihjxtaWq2C7u3MsyqNb0hAhC7yUYEljyowGd+3QecZGL73uUj
         F9iA==
X-Gm-Message-State: APuU4Z9PAWp84jPQ6Mu/hq5GUb2hOJRbeXmOPpdepu10Iwv5p/n5Xsnw
	PgOYVfrn3YkIftLGc4JCH+CfyxeD+O3jACyr9KO1mIOCyPShRORcxNfwz0If33lP
X-Gm-Gg: AYBFou0iRhQomSKeBrYd5an1UQctjETpp3TXH97VyFdn0KamCqcpiFEfAq/n4BkUVab
	yvr2QkOhbwJJ8fVaCpxuGbgaDNRZ/NmST2fYC1nc+3YZNidtA+MIQVtwbXdtyJuVu0MSzs2MKgb
	udoHTVv+vLlmwKjnObZSKSXbEK0YaeAGAVzDP8cJYtRKJYSV4Bf00xHAjiieHKT57tPvXWhJwg2
	uISs+o3Bq9xLpNerFZfXYqiSVPzpb1HJaECSD2/KbNcMusUejH+o5boGU0SR/THrvh2UZVvHPvS
	wwnIkVc9j5vDRJA70N/jpOJKXRyor5XK0XXiojbdYIKOnfXpvk+9Q3zSJcgvCPZc4WpXKRWfiHs
	8kqMZZfivRjXa7KqEsnTEMUs5MNII0apKIg4sa3thrdcQNfzylfBCo/VVgARUItbeTmDZpW2U+L
	ijmrXO6h+FCIdGLki32DRpb5a6alPp7SBgi01EO5+MHX3zxfWdKKazIbJC9g6IperBBDOW37bQ+
	RZemcnQBRE+Ri1eoUDTfB8uV/cIQiz4pOUitdhI9hPj11/tYL9Nu+4XKSLvqFZsSbVsnALLxAGp
	a+cnyrDMYsSD7WbiQcw1Fcv66eSKYw==
X-Received: by 2002:a17:902:da8a:b0:2e9:4175:306e with SMTP id d9443c01a7336-2eb364e1e42mr169732245ad.42.1793833398989;
        Wed, 04 Nov 2026 15:03:18 -0800 (PST)
Received: from cxlqual.. ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed0908587dsm10999175ad.36.2026.11.04.15.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 15:03:18 -0800 (PST)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <iweiny@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Fan Ni <nifan.cxl@gmail.com>,
	Li Ming <ming.li@zohomail.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Gregory Price <gourry@gourry.net>,
	Richard Cheng <icheng@nvidia.com>,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v1 14/14] Documentation/cxl: Document DCD extent handling
Date: Thu,  5 Nov 2026 08:02:38 +0900
Message-ID: <20261104230445.66625-15-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104230445.66625-1-anisa.su@samsung.com>
References: <20261104230445.66625-1-anisa.su@samsung.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a "Dynamic Capacity Extents" section to cxl-driver.rst, describing
when CXL core accepts an offered extent and when a release request
is acknowledged.

Update maturity-map.rst to reflect initial support for "Extent add /
release event handling".  Overall DCD Support stays at [0] until the
DAX layer plumbing lands and extents become usable.

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 .../driver-api/cxl/linux/cxl-driver.rst       | 181 ++++++++++++++++++
 Documentation/driver-api/cxl/maturity-map.rst |   2 +-
 2 files changed, 182 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/cxl/linux/cxl-driver.rst b/Documentation/driver-api/cxl/linux/cxl-driver.rst
index 212df4fb8d63..28f6c0530c8a 100644
--- a/Documentation/driver-api/cxl/linux/cxl-driver.rst
+++ b/Documentation/driver-api/cxl/linux/cxl-driver.rst
@@ -654,6 +654,187 @@ from HPA to DPA.  This is why they must be aware of the entire interleave set.
 Linux does not support unbalanced interleave configurations.  As a result, all
 endpoints in an interleave set must have the same ways and granularity.
 
+Dynamic Capacity Extents
+========================
+
+A `Dynamic Capacity Device (DCD)` advertises capacity in `DC Regions`
+and surfaces individual chunks of that capacity to the host as
+`extents` (CXL r4.0 Section 9.13.3 "Dynamic Capacity Device (DCD)").
+Linux calls a DC Region a `DC partition` (see "DPA Partitions" above)
+so that "region" keeps its software meaning: a :code:`cxl_region` is
+the host-side object that maps DPA into a host physical address range,
+whereas a DC Region is a device-defined slice of DPA space.
+
+Accepting Extents
+-----------------
+Extents are made available to the host through DC Add events: the
+device sends one or more Dynamic Capacity Event Records (CXL r4.0
+Section 8.2.10.2.1.6, Table 8-229) to the host.  Each record carries
+one extent, which the host may accept or reject.  A device offering
+several extents sends one record per extent, chained with `More`: each
+record has the `More` flag set to announce another incoming record,
+until the last record, which carries `More=0` to mark the end of the
+chain.
+
+For each record received, the host stages the offered extent on a
+pending list.  When the chain closes the host knows that every extent
+of this add event has arrived, and the whole pending list is validated
+before anything is accepted.  A chain whose closing record does not
+arrive within 20 seconds is refused as a whole: the watchdog answers
+with an empty Add Dynamic Capacity Response so the device can reclaim
+the offer, and the staged extents are discarded.
+
+From the pending list, extents that share a (non-null) tag are
+extracted into a tag group so that each group can be validated as a
+unit; a group that is accepted becomes a :code:`struct
+cxl_dc_tag_group`.  A tag group is one logical allocation.  An untagged
+extent is an allocation of its own and becomes a single-member group.
+
+Group-level validation (:code:`cxl_validate_group()`,
+:code:`drivers/cxl/core/mbox.c`) drops the whole group if any check
+fails:
+
+* `Host-wide tag uniqueness`: a non-null tag must not already
+  correspond to a live :code:`cxl_dc_tag_group` anywhere on this host.
+  The orchestrator / Fabric Manager owns tag assignment (CXL r4.0
+  Section 9.13.3.1 "DCD Management by FM" and Section 7.6.7.6 "DCD
+  Management Command Set for LD-FAM"); the list in
+  :code:`drivers/cxl/core/extent.c` (:code:`cxl_tag_register()` /
+  :code:`cxl_tag_already_committed()`) catches firmware bugs and
+  orchestrator misbehavior across every region and memdev.  Skipped
+  for the null UUID because there may be multiple untagged extents.
+* `Sequence-number integrity`: extents may be shared across hosts if
+  the device supports memory sharing.  Since a tag group is one
+  logical allocation, every host needs to see the extents of a shared
+  group in the same order; that order is the Shared Extent Sequence
+  Number of each extent (:code:`shared_extn_seq`, Table 8-230).  A
+  sharable group's sequence numbers must form exactly
+  :code:`0, 1, ..., n-1`: sequences with gaps or duplicates, or that
+  do not start at 0, are rejected.  A non-sharable extent must carry
+  0 in the field; that is rejected per extent by
+  :code:`cxl_validate_extent()`, so the group check covers only
+  sharable partitions and the host orders non-sharable extents by
+  arrival.
+* `Partition equality`: every tagged extent in the group must resolve
+  to the same DC partition.  A single allocation cannot span
+  partitions because CDAT describes sharable / writable / coherency
+  attributes per partition.  Skipped for the null UUID.
+* `Alignment`: every extent's :code:`start_dpa` and :code:`length`
+  must be :code:`PMD_SIZE`-aligned, the alignment the DAX region is
+  created with.  If any extent is misaligned the whole group is
+  dropped: accepting only the aligned subset would leave an unusable
+  allocation.
+
+After group-level validation each extent is validated individually
+(:code:`cxl_add_extent()`, :code:`drivers/cxl/core/extent.c`).  A tag
+group is accepted whole or not at all: for sharable capacity the spec
+requires it (Section 8.2.10.9.9.3, otherwise the device returns Invalid
+Extent List), and an allocation missing an extent would be unusable
+either way.  So an extent that fails any of these checks drops its
+whole group:
+
+* The extent's DPA range must lie within a DC partition of the memdev
+  (:code:`cxl_extent_dc_partition()`).  On a sharable partition the
+  extent must carry a tag; on a non-sharable one its shared extent
+  sequence must be 0.
+* The extent's DPA range must resolve to a CXL region via
+  :code:`cxl_dpa_to_region()`.  An extent with no owning region is
+  dropped, as is one whose :code:`dax_region` has not finished its
+  probe-time scan or has no driver bound (see Recovery below).
+* The extent's DPA range must be fully contained in the endpoint
+  decoder's DPA range.  An extent that straddles the decoder boundary
+  is dropped; the driver never clips an extent to fit.
+* The extent must not overlap or repeat an extent already present in
+  the same region (:code:`cxlr_dax_classify_extent()`).  A range the
+  host already accepted drops its group: the device rejects a DPA
+  range reported twice in an Add response (CXL r4.0 8.2.10.9.9.3,
+  Invalid Physical Address).
+
+Surviving tag groups are registered with the device model by
+:code:`online_tag_group()`: a tagged group becomes a
+:code:`tag_groupX.Y` child of the :code:`dax_region` device and every
+member :code:`dc_extent` an :code:`extentX.Y` child of it, while an
+untagged extent goes under the region's :code:`untagged` device.  The
+host then tells the device which extents it accepted with an Add
+Dynamic Capacity Response (CXL r4.0 Section 8.2.10.9.9.3, opcode 4802h)
+per chain, split across several commands chained with the More flag
+when the extent list outgrows the mailbox payload; an extent left out
+of the response is rejected.
+
+Extents the device already reserves for a region, for instance after a
+host crash, are recovered when the region's :code:`dax_region` probes:
+:code:`cxl_region_add_existing_extents()` reads the device's extent
+list (Get Dynamic Capacity Extent List, Section 8.2.10.9.9.2, opcode
+4801h), keeps the extents inside the region's decoder (the list covers
+every DC partition of the device) and runs them through the same
+validation with :code:`existing` set.  No Add Dynamic Capacity Response
+is sent for them, and a recovered group that fails validation or does
+not online is released back to the device.  Add events for the region
+are refused until that scan completes, and again once the driver
+unbinds: unbinding returns every held extent to the device, so the next
+probe scans afresh.
+
+Releasing Extents
+-----------------
+
+A release may be initiated by the device (a Release Capacity event) or
+by the host, for example when tearing down a region.  A host may also
+issue a Release Dynamic Capacity Response not associated with any
+event, an "unsolicited release", at any time (CXL r4.0 Section 9.13.3).
+The host-initiated path runs :code:`dc_tag_group_teardown()` for each
+tag group of the region: it invalidates the region's cached lines,
+returns the group with its own Release Dynamic Capacity Response and
+unregisters its extents.  The device-initiated path goes through the
+release chain in :code:`drivers/cxl/core/mbox.c`.
+
+A device-initiated release may span several event records chained with
+the More flag, exactly like an add event.  Each record is staged in
+:code:`mds->dc_chain` by :code:`handle_dcd_chain_event()`, the same
+chain an add event uses, until the chain closes (More flag cleared).
+Chained records shall be contiguous and share one event type (CXL r4.0
+Table 8-229), so add and release records cannot coincide; should a
+record of the other type arrive inside an open chain, the open chain is
+aborted (an add chain with an empty Add Dynamic Capacity Response, a
+release chain silently) and the record starts a new chain.  A chain
+whose closing record never arrives is dropped by the 20 second watchdog
+the same way, so the capacity stays provisioned for the host and the
+device may retry.
+
+When the chain closes, :code:`cxl_rm_pending()` processes the extents
+staged in the pending list.  As mentioned above, a tag group is one
+logical allocation, so requesting the release of any extent in a group
+releases the whole group.  Members of the group missing from the event
+record chain (an FM mistake or firmware bug) are still included in the
+Release Dynamic Capacity Response as a "generous" policy.
+
+Each extent pending release is processed:
+
+* The extent is resolved by :code:`cxl_resolve_extent()` to its CXL
+  region and :code:`cxl_dc_tag_group`.
+* An extent the host does not own is acknowledged so the device knows
+  the host is not using it: its DPA range resolves to no region, to a
+  region whose :code:`cxlr_dax` is not set up, or to a range that
+  overlaps nothing the host owns (for example, an extent left over
+  from a host crash that has not yet been re-claimed, or a duplicate
+  release racing region teardown).
+* An extent that overlaps capacity the host owns without matching any
+  single accepted extent (it straddles two extents, or the tag
+  disagrees) is held: it is left out of the response so the device
+  retains the capacity for the host and may retry.
+* An extent that names an owned extent releases its group through
+  :code:`cxl_release_tag_group()`: the backing memregion is
+  invalidated once for the group and :code:`rm_tag_group()`
+  unregisters every member :code:`dc_extent` device.  If the
+  invalidation fails, or the :code:`dax_region`'s unbind already owns
+  the group's teardown, the group is left out of the response, so the
+  device retains the capacity and may retry.
+
+After processing the pending list, every extent the host is giving
+back is sent to the device in the Release Dynamic Capacity Response
+(Section 8.2.10.9.9.4, opcode 4803h), mirroring the Add response.  A
+list that does not fit in one mailbox payload is sent as several
+commands chained with the More flag.
+
 Example Configurations
 ======================
 .. toctree::
diff --git a/Documentation/driver-api/cxl/maturity-map.rst b/Documentation/driver-api/cxl/maturity-map.rst
index fefd31899229..13df87038c88 100644
--- a/Documentation/driver-api/cxl/maturity-map.rst
+++ b/Documentation/driver-api/cxl/maturity-map.rst
@@ -151,7 +151,7 @@ Memory-pooling
 * [0] Dynamic Capacity Device (DCD) Support
 
   * [1] DC partition enumeration / configuration (Get DC Config, CDAT DSMAS, event interrupts)
-  * [0] Extent add / release event handling
+  * [1] Extent add / release event handling
   * [0] DC-backed DAX regions
 
 Multi-host sharing
-- 
2.43.0

