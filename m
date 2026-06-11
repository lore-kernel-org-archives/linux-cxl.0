Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF0041930D;
	Thu, 11 Jun 2026 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194188; cv=none; b=Ir3SnhZzcK+iLKdKS++HfTQq2njq+N2vc4DqSdK2gVvMclyqOtxvyI6lEZAXu6RKObj94+DLil1UFU1cwSuJbitLMzu8yma6G87G3W2dLzcPWp8hQ6uO/U7BoX1rwcSl/Jx5tzY3uCxmdkO5mn7IEKcFDLC9gxn13PdKk6ppaCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194188; c=relaxed/simple;
	bh=X4Jpc+wpAAwsnek0hOUnQEIdn0MKFirDP7V0B2MS2ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vAxQJn3gmTEM8HO4lF275mSWS2NOHwQU+0QQdtmu0ZjzX0XqlTQj10Z1uaSVEENgUDTmg88x4oAqN4B3eiusU3rAvlUg7UqmCB5/Z/o/aob4ftH5Yr3LOVB2fDviNGoH7KSCOnqmZK5jcmx+1MCxBoZ52qRzg7aYKjRikJZ8QkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgcmbJ0M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgcmbJ0M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846571F00893;
	Thu, 11 Jun 2026 16:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781194186;
	bh=YjaHrluNbQcW3RW6hKc6GUqxEBJ52tD5SdhNClOzEbQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fgcmbJ0MetdVZUeVJ5A0HVyULJLaT6nRpg6uRYKgl+y/jCCS3ZgEwRFS5Y/faTQZX
	 0970T4XqaBsfe1KKzmeFLFAJhtd3sobbsAKgQUm1TALq/7qwQkhHWYUkbgZa6kAXFL
	 Qyg7kPuR299i+5v0MI+apcqqpSOpCWMb7bdYdzD82tdZWz6qQSrNaicxedQD4HAyyx
	 H0eeLfmNt/y9IQ1UXn6HoGzFKSvwyBYS7RpMSVXI3Fv71cTnwAXMRXjbYq6ttB42uC
	 JxFC/iksGp81nWha0cQlVSNSSl6hCFnlb6aNpgkFKsZ+J3IWHWON3F/VJCPXbQxaO4
	 mqkGyRBzXShbQ==
Message-ID: <7e7cbc60-e9c7-4a63-9d4b-4e8fcad7bfc0@kernel.org>
Date: Thu, 11 Jun 2026 18:09:40 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug Report] Elevated PMD nr_anon after running selftests
To: Nico Pache <npache@redhat.com>, Linux MM <linux-mm@kvack.org>,
 linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-cxl@vger.kernel.org
Cc: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
 Oscar Salvador <osalvador@suse.de>, Andrew Morton
 <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>
References: <c5401e8d-0b46-4cc0-88b3-f438d610e73b@redhat.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzS5EYXZpZCBIaWxk
 ZW5icmFuZCAoQ3VycmVudCkgPGRhdmlkQGtlcm5lbC5vcmc+wsGQBBMBCAA6AhsDBQkmWAik
 AgsJBBUKCQgCFgICHgUCF4AWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaYJt/AIZAQAKCRBN
 3hD3AP+DWriiD/9BLGEKG+N8L2AXhikJg6YmXom9ytRwPqDgpHpVg2xdhopoWdMRXjzOrIKD
 g4LSnFaKneQD0hZhoArEeamG5tyo32xoRsPwkbpIzL0OKSZ8G6mVbFGpjmyDLQCAxteXCLXz
 ZI0VbsuJKelYnKcXWOIndOrNRvE5eoOfTt2XfBnAapxMYY2IsV+qaUXlO63GgfIOg8RBaj7x
 3NxkI3rV0SHhI4GU9K6jCvGghxeS1QX6L/XI9mfAYaIwGy5B68kF26piAVYv/QZDEVIpo3t7
 /fjSpxKT8plJH6rhhR0epy8dWRHk3qT5tk2P85twasdloWtkMZ7FsCJRKWscm1BLpsDn6EQ4
 jeMHECiY9kGKKi8dQpv3FRyo2QApZ49NNDbwcR0ZndK0XFo15iH708H5Qja/8TuXCwnPWAcJ
 DQoNIDFyaxe26Rx3ZwUkRALa3iPcVjE0//TrQ4KnFf+lMBSrS33xDDBfevW9+Dk6IISmDH1R
 HFq2jpkN+FX/PE8eVhV68B2DsAPZ5rUwyCKUXPTJ/irrCCmAAb5Jpv11S7hUSpqtM/6oVESC
 3z/7CzrVtRODzLtNgV4r5EI+wAv/3PgJLlMwgJM90Fb3CB2IgbxhjvmB1WNdvXACVydx55V7
 LPPKodSTF29rlnQAf9HLgCphuuSrrPn5VQDaYZl4N/7zc2wcWM7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <c5401e8d-0b46-4cc0-88b3-f438d610e73b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/26 17:58, Nico Pache wrote:
> Hi,
> 
> While testing my mTHP code I noticed that mm selftests caused an accounting error in
> /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/stats/nr_anon
> 
> At first I thought I might have caused a regression, but when retesting with 7.1-rc5 (without my code), the issue was still present.
> 
> This issue occurs in two mm selftests:
> 1) hmm test
> 2) migration - private_anon_htlb test
> 
> I spoke to David about this and he suggested the following diff which seems to have solved both issues.
> 
> David would you like to send a formal patch or patches?
> 
> Cheers,
> -- Nico
> 
> Diff for (1)
> 
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 053842d45cb1..683a77dd679d 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -425,6 +425,7 @@ void free_zone_device_folio(struct folio *folio)
>         mem_cgroup_uncharge(folio);
> 
>         if (folio_test_anon(folio)) {
> +               mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, -1);
>                 for (i = 0; i < nr; i++)
>                         __ClearPageAnonExclusive(folio_page(folio, i));
>         }

Wasn't there another issue with hugetlb?

diff --git a/mm/migrate.c b/mm/migrate.c
index 8a64291ab5b4..0aec894266f2 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -590,7 +590,8 @@ static int __folio_migrate_mapping(struct address_space
*mapping,
                /* No turning back from here */
                newfolio->index = folio->index;
                newfolio->mapping = folio->mapping;
-               if (folio_test_anon(folio) && folio_test_large(folio))
+               if (folio_test_anon(folio) && folio_test_large(folio) &&
+                   !folio_test_hugetlb(folio))
                        mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
                if (folio_test_swapbacked(folio))
                        __folio_set_swapbacked(newfolio);
@@ -623,7 +624,8 @@ static int __folio_migrate_mapping(struct address_space
*mapping,
         */
        newfolio->index = folio->index;
        newfolio->mapping = folio->mapping;
-       if (folio_test_anon(folio) && folio_test_large(folio))
+       if (folio_test_anon(folio) && folio_test_large(folio) &&
+           !folio_test_hugetlb(folio))
                mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
        folio_ref_add(newfolio, nr); /* add cache reference */
        if (folio_test_swapbacked(folio))


Yeah, if you have some capacity, please send patches (and figure out Fixes:) :)


-- 
Cheers,

David
