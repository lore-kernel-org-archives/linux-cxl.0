Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58490342523
	for <linux-cxl@vger.kernel.org>; Sun, 12 Jul 2026 15:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783871122; cv=none; b=shhdUEwRrS6kH99Jv84N2T6KiuQAGAa87vJh87TEHsvw4N+m0xRggqrSJyYdF+JY5uAQO35E0WCn9/mF8mrOYJsLK7bgyZmXJUpBIhM1R7fGnKhCDvbY12RDzegj28Os07TDNEVLVZ6AE3zUmZ1zFg8HVtJCxH9xjY+HKVzSFjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783871122; c=relaxed/simple;
	bh=tfx6dOdIwwqQC/jjpRe//jhDfVXsvDei4cyYZa9VMO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBalCaG5+yK1SnD0zaFElWJEde9J1NdWkar8eUyu0TBAZVnpV2RoI4axN1V8p3xihzKI1SxZ/FLIWDkXGCc5QCbvN3i5MieCWm+Ni1Ts5XszB1kUEbVn6pfjZXiwVLeJTQo3A2tAU+t71DeWcKrOSrhhbUgzTJqvQpyf7d1PSrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Hd6ZiYZ9; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Hd6ZiYZ9"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e533aacf2so116711985a.2
        for <linux-cxl@vger.kernel.org>; Sun, 12 Jul 2026 08:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783871119; x=1784475919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r1M/Y6Dv0V9NOM4+/puP8NWosRoeWXHurd+5rEoqGA8=;
        b=Hd6ZiYZ9vy8K93CSp1Z34ZGIMASH4elXiBdZXrC6yyBmWbdzdJyIK3O8MSVz+6tsc2
         utX5GWJWE0ABixdnE7u3QW2T6WemFjDfCtJfnaPCUnfEuWEZMPhC14NLdyLzuW5HB/sN
         7Fh90VZPJz4shIXzBdk4LswOsVRPDKJTVHv2vK9NMo8nvSFms1NV/6fxKx1/eXmujuGd
         Or41BZ+BM8jQX7qMCebwTTo66TXNyyIvqFAWfFsZr7X5jvMKgVJWXMf+IrZRvsN5vF3m
         MaTOk9tCNEJ0ZIW4722WeQvyaa4J8MXyYlT28TLT4Q2QRItcbL1Jhe2BIiw/xnpQHtyi
         pQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783871119; x=1784475919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r1M/Y6Dv0V9NOM4+/puP8NWosRoeWXHurd+5rEoqGA8=;
        b=UPiNuXWLh8JWvl4lFBvhJ9g2/riOQ4opFFN+K+h6abqEaKBj/2qAPDw1LLJ8XAK0Gg
         Zd9N1Nc4Ui11xbW3Wfqr5bCsf7vKLUPNS601GIjLDHL3A+YkSOz+2Q9dn7hKRVBd7ylH
         dFivlOLe6G4Wq2avaiG75Lrt3TYB/rafLMjsHs58hQLe6DvFJmo8BmP+jiJbrLT3SfMH
         3FH2DneVAqjjrssKmAYdAbmrLuRBBG/eTgUqd4mLDopQy15pu8OnY7dWxvI+gUVi6jI7
         xKH7nOugV6oZHhvcL7sDHauOw14ZWQfMd65p3PV5G/Gy2rlGZmBl2/sB/viqn6cByU1A
         TMEg==
X-Forwarded-Encrypted: i=1; AHgh+Rrw768/zHpMDVeg7dfBAk32jy/+jIUZwrCY8nj9SKiWcDYRLsBH0KgxZGqnnHAFQcUk4kGJ4K6TCjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlYWt0+8ASQ+SyEyR5J7deoq/ZX0UVZKpNUk4E+2BHi4F+eKmk
	z42WuX8LuWxSA3fWkr6rMyEiN9k/uj1BuHi+Zi8UEsPVIUit8iqACE1OlgZE8cPmTFc=
X-Gm-Gg: AfdE7cm3VTJS5Lsa5LiffPUOKaEOaxCg0xCwsd8AeDTuE9U0gObVj0Hqil22kiD7uI9
	pgWE4iprSXEpXAkoNx6+HtnDPKroJJYFiKOuNZ5OM+4zQ/ms0WXfXC7UL6FoX3fWlY9fq4ERBpG
	Q8hA2skW7guuBjVIxj+xrjn55fq8DzPaftSrYxNvSc20RWDK5weMKpwW7V8yolTltPICd7eXIkF
	7KnaY0tWOiiv/ZJizQd1C4bF9x/q3EOHfP2N3on63iKEUzgr2oNk0hpAdEerWLK3PJH3MqC6rzT
	vf/1Da0HqGeiTYoL1IaI9VaaMszhOGl7N8P+E/XwCq3b36G6dnMLJ4/uzCQmj4JlMlnQaZAoKki
	aqrFZ4Jh8Lvt79sRQDOwQ19AcmsvYLt9+SFB3bTY1kLRRGmgKcmF1SFWrhmgGm3/uYwUdVkC0WC
	roU8g5EJ9XAqNiFyYj0sQO8cTmjLW+V0MbwMSFYM/+5IUp2pb4EsTFNUV95Y8hIxqzwkzxPP+No
	FoXlP7kbZE9
X-Received: by 2002:a05:620a:480c:b0:92e:6533:26eb with SMTP id af79cd13be357-92ef2bb48d0mr596324285a.6.1783871119197;
        Sun, 12 Jul 2026 08:45:19 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d61facsm862186485a.42.2026.07.12.08.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 08:45:18 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	kernel-team@meta.com,
	david@kernel.org,
	osalvador@suse.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	djbw@kernel.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	akpm@linux-foundation.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	shuah@kernel.org,
	gourry@gourry.net
Subject: [PATCH v7 02/10] mm/memory_hotplug: add mhp_online_type_to_str() and export string helpers
Date: Sun, 12 Jul 2026 11:44:56 -0400
Message-ID: <20260712154505.3564379-3-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260712154505.3564379-1-gourry@gourry.net>
References: <20260712154505.3564379-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add mhp_online_type_to_str() as the inverse of mhp_online_type_from_str(),
and export both so a driver can render and parse the memory online type
through its own sysfs interface.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Dan Williams <djbw@kernel.org>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/base/memory.c          | 9 +++++++++
 include/linux/memory_hotplug.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index bcfe2d9f4adbd..5eead3346f1e3 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -46,6 +46,15 @@ int mhp_online_type_from_str(const char *str)
 	}
 	return -EINVAL;
 }
+EXPORT_SYMBOL_GPL(mhp_online_type_from_str);
+
+const char *mhp_online_type_to_str(int online_type)
+{
+	if (online_type < 0 || online_type >= (int)ARRAY_SIZE(online_type_to_str))
+		return NULL;
+	return online_type_to_str[online_type];
+}
+EXPORT_SYMBOL_GPL(mhp_online_type_to_str);
 
 #define to_memory_block(dev) container_of(dev, struct memory_block, dev)
 
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index f04b915678dbd..8f6da2656f4e2 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -127,6 +127,7 @@ extern int arch_add_memory(int nid, u64 start, u64 size,
 extern u64 max_mem_size;
 
 extern int mhp_online_type_from_str(const char *str);
+const char *mhp_online_type_to_str(int online_type);
 
 /* If movable_node boot option specified */
 extern bool movable_node_enabled;
-- 
2.53.0-Meta

