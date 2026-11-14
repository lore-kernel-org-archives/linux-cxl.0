Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640227;
	b=wAgIu+V6X8ZRBdQRP4vgS+i6jyp9p3X4eoJ2uyOMiBu5196qNHHB8eZNF9orVTfGOeD1
	 rKEbgxHKf/h6Mb0UThiMK16fWorW/KmBV1VbDR/l9C17uvp0rvP/tl5KhYINvhGPbzAWM
	 IoXJRYLuFhQ5d+KEE+h52XEx7dDSwHnBL9KsV0B+uou1YDq7IuVE3BW069pRzfE2RHOvl
	 7ExKPrWBK5Ovz0id11Rlq4VoDb2b7T4s1Uac0RQPP1W1oyknJRqtdKQTQ2HHG9SS9qCvb
	 FUk8MTjRbw1NPLcd30FA5mQMrAA+uAS6VPq0u4r4SbnS0ewu7bjRcrHSzCJF18Ry2GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Tt496ll4IbdlqeCDi3ioSW9/vXDsw+lkgrGBEmtKDJU=;
	b=ubNEAMJE9uIuyZQtjqoKK8xsPVvO69LBMVtveIbqiQfyn/J987WYyZ3SyNy+HBC2uVKa
	 aZg//cwaVp+RgB0EkV9Qhw41mi7c7dS2S19g5iOjzCljwJaoVkX4y/tpk4Ldn2M6jUY/V
	 QcuJYrKLLB0McgfQxOYvkkOUkzBOu+stSVzKKXOULnlJx5QU5sNsM9VVuPqKHyOyLD+xh
	 PoGD8NPZk2fE89Db8KwgitFp0iwDNtz4Pi6CWblTCaIHWmcONKmx1gavLAGaKxcDhvBxC
	 U6zFXcWw7JdR3UziYK5n6oOMbKtbD9gtqMXKOITXLHQ7ChBGBhkFFMGqH3RVj2qbFcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Wak6pwPF;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B18B60A5BE1
	for <linux-cxl@vger.kernel.org>; Sat, 14 Nov 2026 07:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B18B60A5BE1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Wak6pwPF
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91f23ddf32fso12082296d6.0
        for <linux-cxl@vger.kernel.org>; Fri, 13 Nov 2026 23:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640226; x=1795245026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tt496ll4IbdlqeCDi3ioSW9/vXDsw+lkgrGBEmtKDJU=;
        b=Wak6pwPFiUkKyhQgMf4rS7ScgYnhLHPu/BQFbJsFq7WKKXSUOmiu+EsQFsjVZ8zFDO
         FDrlS7y+5O55UEGv/kTSaX8dffsOnEXEa6/2U/GCtWcFwv0S/O1x4yRSmj13AtftFa/d
         2LHhZ1Xzh9y1vx57sBVWmEQqxXZeF/gRFDaivKFbqeTHuyd1MOWBIFDDx6qnA+nzwI3j
         f0FWi5bqe5XptEAAFE0ZLXHTalZ4ObmYUba1bTQ7a5ucsWoZ5b9b8qD9ay1zcLACOuUw
         HN4jHEZ3DD/E9fTfoTkj/qDM3H/u15Vo16V1SDswP6q5IvcI5vpIGBny10cK9BBE6q/X
         KPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640226; x=1795245026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tt496ll4IbdlqeCDi3ioSW9/vXDsw+lkgrGBEmtKDJU=;
        b=Uf2z/Cy2kVZw64ncsySM5yewXEFfghVqOEUoCb2XyKsrmhRrgUMn0wQ5M2ketrqJAQ
         PyJGSyorsH+dlJX2eyQwP1fGnTCeL4LYfGwIZiwboAF0l83oAfZ+XCE33AyCqXZU2dFR
         dx4YC6m1h8VgbYeypx4XUoyehvWQnyLFs0GLX0IgmLeu/o9TXZT5F+Td92bjhbNl+YqB
         l01044y6YgHBs/oaRNhQYu+n7SXJe8yOUdhBP2cb/nzNKvqnyGuGilf9x0AVRJ7xrrJq
         PsAB7SYnMQP3tyXFL3n6PLjuOkPFDobkt+qUnYJetAD8qax6UReEbAeyl86pxoGNqr3c
         gOwQ==
X-Forwarded-Encrypted: i=1; AL+hErH+lZprpcqFEVsRxhnk2N1mw7CsJE0fuUgzFff7muWYr52XpIFWWWFyp54DQZpV13viQrwh9wJA/gI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8YTzGlf/dO8bRdbgf7T15pwHGwwFmy/UqIFf2xSJ5ogjlHYXKx
	GWsWSIRwXm0nFJR2ieV5fqukntk/vq9jgl2aJjn2DhOhESWWU1QpmecBOrvfR9sIqK0=
X-Gm-Gg: AYBFou2F+mCLk3jOIL1q0quYcXlZ+XvrW1QWKwO86PjyboVMedmBSkIEuYCQqmkKEQW
	hHjxss2z6YLnYKwZzaO9cIEY5lJDfKgDFFaP2HjDsvAZ+zOJLaEio11k4Z1D40LrbrhOgFSFOrj
	zY/tdZmfSky4Sq/eR7B0p5g6tWc3be34kYBFEsQihmpImtHrQMWBODBwgOvu2XmomWZEFDj1RiE
	N/d4dOTe0J1T6JsHJbXyd+1SNf+H6x4nhZAvmG4h0YEDbwrj4r9Ffzxm7ehXqb8BAWWwrajkZS9
	CJdqG6Rp7w9JMfzz/kNSGKK2jKb5sqf+ZNpXPhojS6A2JTygN4Vo50gV/SpcPFmPrqiOH1s89JL
	Wg2A203fIn3JiVC27FNzpCASjMxblo091paWqJ7b6p+LOPRFzl7VrbZiVF3JYnCtBsSd6uYpfmc
	izuX7aLcJQfPQDlYbLsSLERvdBRYCmkuwAIvV2jjDKVeb8Oh9o4ROA6fLL29TNW1hnIMnVWP6Kf
	yB6JX5cjGStplxlZhVG3slT496FqVtQCAbdLI+gH8tgV0BTeGURF2kBou6Uj9SO9EdXfL0omVK5
	CQ0fovVNrKH9ChLDHsJaEkbwun/4GDHoFWAXQBwefUFv+8w+aezcaLiLTJUNH6B5isW+o7FCLeL
	53n11u5I3z8YKA4U=
X-Received: by 2002:a05:6214:e8a:b0:91e:7bb7:fd65 with SMTP id 6a1803df08f44-91f24292699mr81332616d6.56.1794640225203;
        Fri, 13 Nov 2026 23:10:25 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:24 -0800 (PST)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-serial@vger.kernel.org,
	linux-pm@vger.kernel.org,
	damon@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	johan@kernel.org,
	jirislaby@kernel.org,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	pavel@kernel.org,
	lenb@kernel.org,
	hannes@cmpxchg.org,
	brendan.jackman@linux.dev,
	ziy@nvidia.com,
	sj@kernel.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	matthew.brost@intel.com,
	byungchul@sk.com,
	apopple@nvidia.com,
	rientjes@google.com
Subject: [PATCH 10/22] mm/khugepaged: restrict collapse to common memory
Date: Sat, 14 Nov 2026 02:09:47 -0500
Message-ID: <20261114070959.3490008-11-gourry@gourry.net>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261114070959.3490008-1-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
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

Collapse is an opportunistic MM service and should operate only on
common memory. The anonymous scan and isolation paths already filter
zone device for the same reason.

Replace the zone_device check with page_is_common_memory().

collapse_scan_file() gains a folio_is_common_memory() check. Page-cache
folios are never ZONE_DEVICE, so there it only filters memory outside
N_MEMORY_COMMON.

All memory is common at this point, so behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/khugepaged.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4bbe319ef86fa..b4bd29f25c145 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -628,7 +628,7 @@ static enum scan_result __collapse_huge_page_isolate(struct vm_area_struct *vma,
 			goto out;
 		}
 		page = vm_normal_page(vma, addr, pteval);
-		if (unlikely(!page) || unlikely(is_zone_device_page(page))) {
+		if (unlikely(!page) || unlikely(!page_is_common_memory(page))) {
 			result = SCAN_PAGE_NULL;
 			goto out;
 		}
@@ -1673,7 +1673,7 @@ static enum scan_result collapse_scan_anon(struct vm_area_struct *vma,
 		}
 
 		page = vm_normal_page(vma, addr, pteval);
-		if (unlikely(!page) || unlikely(is_zone_device_page(page))) {
+		if (unlikely(!page) || unlikely(!page_is_common_memory(page))) {
 			result = SCAN_PAGE_NULL;
 			goto out_unmap;
 		}
@@ -2741,6 +2741,12 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
 			break;
 		}
 
+		if (unlikely(!folio_is_common_memory(folio))) {
+			result = SCAN_PAGE_NULL;
+			failed_pfn = folio_pfn(folio);
+			folio_put(folio);
+			break;
+		}
 		node = folio_nid(folio);
 		if (collapse_scan_abort(node, cc)) {
 			result = SCAN_SCAN_ABORT;
-- 
2.53.1-Meta

