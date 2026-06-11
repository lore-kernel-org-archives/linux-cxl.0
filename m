Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925FF74C14
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781193469; cv=none; b=EnZZKSKEn9JMQ1Vxshb/kRY5uufpw8qZUCQb5vAfGNpONBx1G9PIL/gIO7sdh+1RFbBlJjsA/Exk0xSOBN5N5gXXjRnuR8EvXgYnvDDt1nzAx7eEsN4Qp5k4Xex97FBGc/K95mDVUZuSyDu1dmhDREWIQhdEOA1YYU0M7lMp9kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781193469; c=relaxed/simple;
	bh=aC/D50n3Vajj/M13O+SFcV+z/+bePeVahMg066WCexE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=U3tO963/cZtq2QhZdZ1sjdAvcZf7V8mYP7dS34nKEhIxnkGAev0ckNL+2J+MZr30fOdDWtFxGmRl7F80Zihja0yrlctBy5b6RoaOwO+6/U2+GoWZH0WpU3YjQhTKtRyNnFBhGsAThpvUTcxdVZRDX61w9zI8t5BpaYmztAKQNSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bkaPjTca; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bkaPjTca"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781193465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CaTVBIrexKm22hRMB++bwqNcNQ1H7GPFCEOimwy1d5I=;
	b=bkaPjTcaz/CuhGg3GJZmEtzdX3Ujn+UGGXbjrXNPaPgwlPbntr0DXoN+7YD4AowZ2t4wWh
	sfe92c5JMuaL4nglrqMzVu+Ecc+J+0qKu/7hMBA60RsgCfHXjlqr/TPmQWAX0PDzo1szLR
	pLBEBdUV60zqo0lMguTiBw9gGC3VxRw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-0V88l0moMHu2VgEqjWIMeA-1; Thu, 11 Jun 2026 11:57:44 -0400
X-MC-Unique: 0V88l0moMHu2VgEqjWIMeA-1
X-Mimecast-MFC-AGG-ID: 0V88l0moMHu2VgEqjWIMeA_1781193463
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490c840efe6so9665455e9.1
        for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 08:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781193463; x=1781798263;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CaTVBIrexKm22hRMB++bwqNcNQ1H7GPFCEOimwy1d5I=;
        b=MJ/ic0O5e4KmFJ7Mr6AIw/1yG1Kp85Vsg0pXk+2mKMTmEVmy6NuaaZjytAR42kpUl6
         hr1HkYIhUyAELA5LWsCLWIB+S4fDkQY6AzwO5RLgP7ipEAUkSgwLk9vS+rPhwUOtw6E3
         /kRhd4/UzDTgJsgF7VTAzuCXy9eUOgaqjBJ6exQ6sGVA80kEl+ZITBcYSbawArbsm3te
         09ekDdBB1NzTeSandNaI7w5Xg6ySDQbcE6ZTT6R21hH4aXAH5Yv9sLQse+r2JxgWqV8L
         kfnkL2XOZK2W4aast0lHRTWmsPDmZ9lJtsGfBPgarNmpy3/AlLUbziy0oz1yxqIav1os
         zFOw==
X-Forwarded-Encrypted: i=1; AFNElJ8z2g/LjMQxLNId7rUw5mDMhuElPVhfUwBAMiGizJqDq6EAVdA7DgodHOHIZSfz00a9WHxggbDWSkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdhmdXGAJLQTL6fZ1fhIdfycsLasZJtyQVASaczZAhzSGewcEV
	ckRRSqupPc89b5cTs8W9e3de1n1FbLP0LCIIiJmuK8tL/N7+VibZpjgKKP8yN+3hWqIXM1xHQRG
	bNdCZtddVV61qNZvJPRDibYqDrmDKgWv6O3rt24ISKeF0gl9gM+7v1iLOoNdxHQ==
X-Gm-Gg: Acq92OG+VrkLbThQ8rWj3Nq17Sn7FtSqqgsXHEeNkhsEiEuhl454ffsjPIejLV27dJ7
	t64mdCt++9aZxYlnfwsoRr5tY7UEkO5Z4IBoXAEwSXSTxvvh01SZB4zEQc0xISFfCXZRWkjT81J
	lcw/HxCKq8fHlgcae/yeo9K+Z+/sZEH2HecKgHObKBjNQO4D1VYPTxa3MUGPoJf5kHim6AgupVk
	93XzvlZE/BxUFjwIICf5lqrtkbdeIVaZ2GuWlwbBX0Jd2n8vJEpPb1v7OC5X3e/zEAgSnsw5QDW
	NzAfG47BbSlNQ+XD1CMqLzRoKMTWHVAoQ33TGJ2ek8ta9eu6tQXm0sNDCB5JeK1GlzezqXZvQnZ
	rU8XknTqb92PZfqWTw4iCelAegHePQaxmlhBPTKwtEnhXkLdfWVroKkbo3zhYlseELKIcPVClhA
	g=
X-Received: by 2002:a05:600c:3ba7:b0:490:9dc3:3483 with SMTP id 5b1f17b1804b1-490e52cad04mr42831515e9.2.1781193463168;
        Thu, 11 Jun 2026 08:57:43 -0700 (PDT)
X-Received: by 2002:a05:600c:3ba7:b0:490:9dc3:3483 with SMTP id 5b1f17b1804b1-490e52cad04mr42830875e9.2.1781193462659;
        Thu, 11 Jun 2026 08:57:42 -0700 (PDT)
Received: from [172.31.99.182] (91.red-83-48-118.staticip.rima-tde.net. [83.48.118.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2c7ead0sm84150385e9.3.2026.06.11.08.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 08:57:42 -0700 (PDT)
Message-ID: <c5401e8d-0b46-4cc0-88b3-f438d610e73b@redhat.com>
Date: Thu, 11 Jun 2026 09:58:55 -0600
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nico Pache <npache@redhat.com>
Subject: [Bug Report] Elevated PMD nr_anon after running selftests
To: Linux MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux-cxl@vger.kernel.org
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>,
 "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
 Oscar Salvador <osalvador@suse.de>, Andrew Morton
 <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: I_PYulM34UjKvvliCUuvbjaERFk10fPWsRNsVZm-ILY_1781193463
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

While testing my mTHP code I noticed that mm selftests caused an accounting error in
/sys/kernel/mm/transparent_hugepage/hugepages-2048kB/stats/nr_anon

At first I thought I might have caused a regression, but when retesting with 7.1-rc5 (without my code), the issue was still present.

This issue occurs in two mm selftests:
1) hmm test
2) migration - private_anon_htlb test

I spoke to David about this and he suggested the following diff which seems to have solved both issues.

David would you like to send a formal patch or patches?

Cheers,
-- Nico

Diff for (1)

diff --git a/mm/memremap.c b/mm/memremap.c
index 053842d45cb1..683a77dd679d 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -425,6 +425,7 @@ void free_zone_device_folio(struct folio *folio)
        mem_cgroup_uncharge(folio);

        if (folio_test_anon(folio)) {
+               mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, -1);
                for (i = 0; i < nr; i++)
                        __ClearPageAnonExclusive(folio_page(folio, i));
        }
-- 
2.54.0

For (2) he suggested

diff --git a/mm/migrate.c b/mm/migrate.c
index d9b23909d716..9fd50ea25d2d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -590,7 +590,8 @@ static int __folio_migrate_mapping(struct address_space *mapping,
                /* No turning back from here */
                newfolio->index = folio->index;
                newfolio->mapping = folio->mapping;
-               if (folio_test_anon(folio) && folio_test_large(folio))
+               if (folio_test_anon(folio) && folio_test_large(folio) &&
+                   !folio_test_hugetlb(folio))
                        mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
                if (folio_test_swapbacked(folio))
                        __folio_set_swapbacked(newfolio);
@@ -623,7 +624,8 @@ static int __folio_migrate_mapping(struct address_space *mapping,
         */
        newfolio->index = folio->index;
        newfolio->mapping = folio->mapping;
-       if (folio_test_anon(folio) && folio_test_large(folio))
+       if (folio_test_anon(folio) && folio_test_large(folio) &&
+           !folio_test_hugetlb(folio))
                mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
        folio_ref_add(newfolio, nr); /* add cache reference */
        if (folio_test_swapbacked(folio))
-- 
2.54.0

