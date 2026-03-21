Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B718E3921DB
	for <linux-cxl@vger.kernel.org>; Sat, 21 Mar 2026 15:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774105465; cv=none; b=M4fkSN2+3gutNO78MJMVYM57llC5PNP/GFvN3TdYVSHUPeQXlaaXIRMH36gkiHRg5N4uxL8QFWBfOb2esy2u+iBJUjG2VoH7qUZ37nuIAS/C16hSA0RFhe2WnnMwnsOdyj+tz7fQDo3v9IlIWt84pEo5c8sGlYpLDD/oT/AGaro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774105465; c=relaxed/simple;
	bh=rF+DX+JfgUHRP6PxAjzMWPOUKYEy9HGwrNkxn2i6BO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmtKL3mI5gdxuhoqUKquGGFyITgLorf5QzcGrAo9YRfHWDS4bIpDEZE2vLldUvZszUSggb4BRS60t9k2oIhI8JmYpzNzmC8rOiq9SlZt+Wk0qoF8PeczwbOi3QrsE/71wE9XcxEa8NIZE7uL99zKwcAa9ixsTuZTtVY6NLAwyFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qWNQs8ox; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qWNQs8ox"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8cd8576a512so443005285a.0
        for <linux-cxl@vger.kernel.org>; Sat, 21 Mar 2026 08:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1774105458; x=1774710258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vvnYDBDYSd91JS5VlgcZ1pjC7MUK2Lw1jakydB3PHI=;
        b=qWNQs8oxsOzKWa5EarGQo2j3wjBilO/R0/OFgHYAIpgz/2ZAgARYiLfJx1587OCLm9
         XSOf8SiejkbndGbn8ArkHqtFSYE85O4/sZ9ikG88Mt30e9g/jJ3gAHYZn1nwpfcMD4h8
         7FNyqyR4vT8va25+nq92GvCnn99WuMB61DRcWpx8CX4rQj9IE4OidBrOg3kapWX61xpW
         GOyswXcdtR6EjaE2V1fzmdDzNQ291LGkRFo5MmG7wHcW2dVBR2Twsd/XCFpF6H1dbCCO
         1owcX7Oq5aRzWJ9N6Y67x5Rocu1ATQoefJzqUaQjpd9h8IFvnwkfyH3REK5ez0tpIIDU
         u+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774105458; x=1774710258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9vvnYDBDYSd91JS5VlgcZ1pjC7MUK2Lw1jakydB3PHI=;
        b=H+T8HK14aXuAMiJVvfZgvnEXJyOlF9ZZa/Ikclser5cwzeXBYLzXEA27gRe3r7d5uZ
         gccO29RdQihz1LXCR34QobEaNl8PFU52Dy2MZ4Z8qAySRe2qB+OwrfEjQx3aZGmAvxOy
         Tvykv6WwBcdk3dlftN14yG6Oak1UC0R8WaeEamEqaWUYx04FVtq/fhsJm/aW9/b3e9oH
         eDTH8PXdV56oe9mN07h4wmODpR1p22jowuxUzrP8/8+gGSUaip/G183StnizeHHJGJPm
         Zu7dSCQcT2i/f/77gZYCv8b7Xz55Wc9A9XEJmCk2W5SfdTsUTiGyV1RKJKcBkTE90yYq
         r13g==
X-Forwarded-Encrypted: i=1; AJvYcCWcGWZUZ0P4+iDKCt0ur1ta7TtxvYluwfiTL3f7NSMpSyWuc6d5cDicIz2+yWhfwFRmAL8hH6cthZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEF8tB1jflHM1q2TZeXJq+jacxkKS6RO3qiKTg78VkBDTaaQm5
	T6YPU0d0l97iLjldZSm6jq7KkTMwfV1WpBnJWqx5Vp+XGK1DKqk3b0vpWZAd96rBIfc=
X-Gm-Gg: ATEYQzzbLWWNslDc0DV4D8zQxnXjpbXsUWP0M1eiFz0HjQNUzVQ7XnPbdm6gGbG8f4H
	7QibPXvIgWpIWun+EddqYHoFGSg5f71y/f42vl4Z9hPOR3m8XhOyIevI91nreKvTwxixa1309JH
	/WHDnppSgWTUkQYHwPEIX+kbWo31NsIFju8jxEgWewuXDrBtzEIweer3/5m02mzBPgI5lPtE3RX
	NMl0KfFC01efPXk0jd5EAGEBLZmFiR/WGdQKpMDHvC9vA0IRjcmmVKhpmcqsENbxJ6n3biXJgJC
	So+0KvZpE/L6aDzVWaJChyvNPH+o832Fl2DmYAtM3yVD/MXT4VnCNQAKD8gouuBZ1LLKWhELG6q
	JcXhQIm36yhmCoB36rPsND4BJWMQbxF+taRFEv5A0w/XWSsQ6FE3kf6/p8kkgn2rQ+oBuZxkcbh
	VLscy4fcv1A+rXIs8hm2qYogCIueVHEvpyB4aVTHp4dAjFAOmIx7mFeyT0TTtBbmAVuga/cmIAq
	caICw8+FSlIg/UlPEB0tuoCZQ==
X-Received: by 2002:a05:620a:410c:b0:8a6:92d1:2dae with SMTP id af79cd13be357-8cfc795a1famr877339485a.5.1774105457588;
        Sat, 21 Mar 2026 08:04:17 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc90ba89fsm391979885a.40.2026.03.21.08.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 08:04:17 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	osalvador@suse.de
Cc: dan.j.williams@intel.com,
	ljs@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 5/8] mm/memory_hotplug: add __add_memory_driver_managed() with online_type arg
Date: Sat, 21 Mar 2026 11:04:01 -0400
Message-ID: <20260321150404.3288786-6-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321150404.3288786-1-gourry@gourry.net>
References: <20260321150404.3288786-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Existing callers of add_memory_driver_managed cannot select the
preferred online type (ZONE_NORMAL vs ZONE_MOVABLE), requiring it to
hot-add memory as offline blocks, and then follow up by onlining each
memory block individually.

Most drivers prefer the system default, but the CXL driver wants to
plumb a preferred policy through the dax kmem driver.

Refactor APIs to add a new interface which allows the dax kmem and
cxl_core modules to select a preferred policy.  Only expose this
interface to those modules to avoid confusion among existing API users
and to limit usage in out-of-tree modules.

Refactor add_memory_driver_managed, extract __add_memory_driver_managed
- Add proper kernel-doc for add_memory_driver_managed while refactoring
- New helper accepts an explicit online_type.
- New help validates online_type is between OFFLINE and ONLINE_MOVABLE

Refactor: add_memory_resource, extract __add_memory_resource
- new helper accepts an explicit online_type

Original APIs now explicitly pass the system-default to new helpers.

No functional change for existing users.

Cc: David Hildenbrand <david@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/memory_hotplug.h |  3 ++
 mm/memory_hotplug.c            | 60 +++++++++++++++++++++++++++++-----
 2 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index a8bcb36f93b8..1f19f08552ea 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -320,6 +320,9 @@ extern int __add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
 extern int add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
 extern int add_memory_resource(int nid, struct resource *resource,
 			       mhp_t mhp_flags);
+int __add_memory_driver_managed(int nid, u64 start, u64 size,
+				const char *resource_name, mhp_t mhp_flags,
+				enum mmop online_type);
 extern int add_memory_driver_managed(int nid, u64 start, u64 size,
 				     const char *resource_name,
 				     mhp_t mhp_flags);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index af9a6cb5a2f9..9081aad5078f 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1492,10 +1492,10 @@ static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
  *
  * we are OK calling __meminit stuff here - we have CONFIG_MEMORY_HOTPLUG
  */
-int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
+static int __add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags,
+				 enum mmop online_type)
 {
 	struct mhp_params params = { .pgprot = pgprot_mhp(PAGE_KERNEL) };
-	enum mmop online_type = mhp_get_default_online_type();
 	enum memblock_flags memblock_flags = MEMBLOCK_NONE;
 	struct memory_group *group = NULL;
 	u64 start, size;
@@ -1583,7 +1583,7 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 		merge_system_ram_resource(res);
 
 	/* online pages if requested */
-	if (mhp_get_default_online_type() != MMOP_OFFLINE)
+	if (online_type != MMOP_OFFLINE)
 		walk_memory_blocks(start, size, &online_type,
 				   online_memory_block);
 
@@ -1601,7 +1601,13 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 	return ret;
 }
 
-/* requires device_hotplug_lock, see add_memory_resource() */
+int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
+{
+	return __add_memory_resource(nid, res, mhp_flags,
+				     mhp_get_default_online_type());
+}
+
+/* requires device_hotplug_lock, see __add_memory_resource() */
 int __add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags)
 {
 	struct resource *res;
@@ -1629,7 +1635,15 @@ int add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags)
 }
 EXPORT_SYMBOL_GPL(add_memory);
 
-/*
+/**
+ * __add_memory_driver_managed - add driver-managed memory with explicit online_type
+ * @nid: NUMA node ID where the memory will be added
+ * @start: Start physical address of the memory range
+ * @size: Size of the memory range in bytes
+ * @resource_name: Resource name in format "System RAM ($DRIVER)"
+ * @mhp_flags: Memory hotplug flags
+ * @online_type: Auto-Online behavior (offline, online, kernel, movable)
+ *
  * Add special, driver-managed memory to the system as system RAM. Such
  * memory is not exposed via the raw firmware-provided memmap as system
  * RAM, instead, it is detected and added by a driver - during cold boot,
@@ -1649,9 +1663,12 @@ EXPORT_SYMBOL_GPL(add_memory);
  *
  * The resource_name (visible via /proc/iomem) has to have the format
  * "System RAM ($DRIVER)".
+ *
+ * Return: 0 on success, negative error code on failure.
  */
-int add_memory_driver_managed(int nid, u64 start, u64 size,
-			      const char *resource_name, mhp_t mhp_flags)
+int __add_memory_driver_managed(int nid, u64 start, u64 size,
+				const char *resource_name, mhp_t mhp_flags,
+				enum mmop online_type)
 {
 	struct resource *res;
 	int rc;
@@ -1661,6 +1678,9 @@ int add_memory_driver_managed(int nid, u64 start, u64 size,
 	    resource_name[strlen(resource_name) - 1] != ')')
 		return -EINVAL;
 
+	if (online_type < MMOP_OFFLINE || online_type > MMOP_ONLINE_MOVABLE)
+		return -EINVAL;
+
 	lock_device_hotplug();
 
 	res = register_memory_resource(start, size, resource_name);
@@ -1669,7 +1689,7 @@ int add_memory_driver_managed(int nid, u64 start, u64 size,
 		goto out_unlock;
 	}
 
-	rc = add_memory_resource(nid, res, mhp_flags);
+	rc = __add_memory_resource(nid, res, mhp_flags, online_type);
 	if (rc < 0)
 		release_memory_resource(res);
 
@@ -1677,6 +1697,30 @@ int add_memory_driver_managed(int nid, u64 start, u64 size,
 	unlock_device_hotplug();
 	return rc;
 }
+EXPORT_SYMBOL_FOR_MODULES(__add_memory_driver_managed, "kmem,cxl_core");
+
+/**
+ * add_memory_driver_managed - add driver-managed memory
+ * @nid: NUMA node ID where the memory will be added
+ * @start: Start physical address of the memory range
+ * @size: Size of the memory range in bytes
+ * @resource_name: Resource name in format "System RAM ($DRIVER)"
+ * @mhp_flags: Memory hotplug flags
+ *
+ * Add driver-managed memory with the system default online type set by
+ * build config or kernel boot parameter.
+ *
+ * See __add_memory_driver_managed for more details.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int add_memory_driver_managed(int nid, u64 start, u64 size,
+			      const char *resource_name, mhp_t mhp_flags)
+{
+	return __add_memory_driver_managed(nid, start, size, resource_name,
+					   mhp_flags,
+					   mhp_get_default_online_type());
+}
 EXPORT_SYMBOL_GPL(add_memory_driver_managed);
 
 /*
-- 
2.53.0

