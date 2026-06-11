Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4EE331EBD;
	Thu, 11 Jun 2026 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195962; cv=none; b=ngXGi+/fXEcowKN0j6F5wVY4vs6qqE65fxcixy/leOGnJYCdQjr/C8oYs6WV8xdx5sugI9TVmno7q4FMOfm0WqahFtJleGFigRA4YOsxdd2JnqlzDSZUbC8ONh+EpxufNiWenwYZULC9tF9W0KaJ80OCE5Km0mKkqFXOxXG69fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195962; c=relaxed/simple;
	bh=hasXvVLG/gODkcBEMTA+RRTXcriCUdW2mKBOU/kxIMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmoA0f7u74s7uzugk7iBQ4Ghx1TmsuyvSS3Jy5aXt1AMcPHvca5MwFSG7s0hp+YKmA3uJVn+ma39wsMxti0NIOJtQLvuFRIgCV0wUqU+RwMDKFRsL2b9TTm3xiTlPF3dnh4E15Xq0xTWLLvPoWmfV0fkRnAWbbxMstr+f+Ls6x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJECdmOl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJECdmOl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56DC21F00893;
	Thu, 11 Jun 2026 16:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781195961;
	bh=i8j+1zlC7hMJNqYIVOq0PFbMVTaou4UfvLB7ez4lCWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XJECdmOlaPRVHdUcTH+MqiDeBXH/ihHo1yWSAp7cQRCxWOovqzrvRf41RfpspPUgO
	 4wDZoi3b/ZhMzO8cwj6w/FW3gABWTyRKiM+C5wfdckRCLVkCI9Tgl8cKHCS6gGjq5d
	 hFQfnj7KCq9gFrqEcZB7dCBhNoLa9eyZxkzmT0tPwTZIWc0Jo5EmJiB7YoFhdl1jRK
	 Q84Qrs82Eg2nuSaN+8fdQ6fW4qgf5qOS4tHRnEtmWBalpzjcBmTQn1yefVKNB3JcQq
	 BzQlqEBOe5z+JtdJljfcdsMJdcJT2br/ExmR7cTqgp1cmgB32EROIOGG7V7tm4lFWu
	 PPraFMdpLYt3A==
Date: Thu, 11 Jun 2026 17:39:13 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Nico Pache <npache@redhat.com>
Cc: Linux MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, linux-cxl@vger.kernel.org, 
	"David Hildenbrand (Red Hat)" <david@kernel.org>, Oscar Salvador <osalvador@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>
Subject: Re: [Bug Report] Elevated PMD nr_anon after running selftests
Message-ID: <aireq_jrgKH0zsNy@lucifer>
References: <c5401e8d-0b46-4cc0-88b3-f438d610e73b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5401e8d-0b46-4cc0-88b3-f438d610e73b@redhat.com>

On Thu, Jun 11, 2026 at 09:58:55AM -0600, Nico Pache wrote:
> Hi,
>
> While testing my mTHP code I noticed that mm selftests caused an accounting error in
> /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/stats/nr_anon

You're not giving any details? how does this manifest? How did you detect?
Output? Etc.

>
> At first I thought I might have caused a regression, but when retesting with 7.1-rc5 (without my code), the issue was still present.

Seems to be a regression in your editor's line wrapping... ;)

>
> This issue occurs in two mm selftests:
> 1) hmm test
> 2) migration - private_anon_htlb test

OK that's useful, but what exactly happened? Any test output?

>
> I spoke to David about this and he suggested the following diff which seems to have solved both issues.

Whilst speaking to people off-list/elsewhere etc. is totally fine, I'd suggest
engaging with the community as the first course of action is often a good way of
resolving things.

Even if things arise from private discussions, which is also totally fine,
please do give sufficient context so that the community can engage with it.

And I would suggest that ideally you phrase things such that you are asking the
community as a whole :)

>
> David would you like to send a formal patch or patches?

So on that point, I understand you're asking David specifically because he
suggested the patch, but I feel that you'd get better results making it clear
that you want community input :)

As one might misread this, and perhaps other such occasions, as you feeling THP
== 1 person, which I am absolutely sure is not how you feel, but phrasing things
a little differently would help underline that :)

Kernel review and maintainership can be rather a thankless task, so details like
this matter I feel! [and I realise I probably screw up on this regularly too so
we're all constantly learning :)]

>
> Cheers,
> -- Nico

Thanks, Lorenzo

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
> --
> 2.54.0
>
> For (2) he suggested
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index d9b23909d716..9fd50ea25d2d 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -590,7 +590,8 @@ static int __folio_migrate_mapping(struct address_space *mapping,
>                 /* No turning back from here */
>                 newfolio->index = folio->index;
>                 newfolio->mapping = folio->mapping;
> -               if (folio_test_anon(folio) && folio_test_large(folio))
> +               if (folio_test_anon(folio) && folio_test_large(folio) &&
> +                   !folio_test_hugetlb(folio))
>                         mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
>                 if (folio_test_swapbacked(folio))
>                         __folio_set_swapbacked(newfolio);
> @@ -623,7 +624,8 @@ static int __folio_migrate_mapping(struct address_space *mapping,
>          */
>         newfolio->index = folio->index;
>         newfolio->mapping = folio->mapping;
> -       if (folio_test_anon(folio) && folio_test_large(folio))
> +       if (folio_test_anon(folio) && folio_test_large(folio) &&
> +           !folio_test_hugetlb(folio))
>                 mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
>         folio_ref_add(newfolio, nr); /* add cache reference */
>         if (folio_test_swapbacked(folio))
> --
> 2.54.0
>
