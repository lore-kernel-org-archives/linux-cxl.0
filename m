Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179EE26AC5
	for <linux-cxl@vger.kernel.org>; Thu,  3 Sep 2026 00:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788396764; cv=none; b=HnuUwYk3X3RBarSWu2TdLDEhT1JuicPmonP8rJ1JuqU3NdQeWibN8DkT3uLNpW86kVUGAXEunRGSyChPImJIZvdY9/dsIek2zV4FK7xbbBrvMRz/UpEMMCqYufUaIrPcHDjqRCrDwsDp+Iv5ddjU2yfbAvLINvJacbmn5eFidnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788396764; c=relaxed/simple;
	bh=E1KnhYl1vseAGA2a1YjLHXlwpoHA5xlkvU5SzwMaMvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pG2YD8zZoMU9hqq/uIiTnrQyKDtCoaRaQrDbMB892/IDjJh+vTn3uGtEjezJShjhFVyAtL4ldpfz91Pw1AoSS6hMLbOzY8euJm4HwO4oCo8+KOi0vQXXaZi7ob8mAQybNGEUqVs9EPPExgLlVTXastLq8kpUooCUYIB0s2SQ4iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=OUIsMSIX; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="OUIsMSIX"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5218927884fso26883371cf.3
        for <linux-cxl@vger.kernel.org>; Wed, 02 Sep 2026 17:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788396762; x=1789001562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PJgfeG9OkO77dXNQBRcYGcD7KsQqp8aI0V+XoArsabk=;
        b=OUIsMSIXVuuC309iA4fD0vBwKIsj/CLLvvAA37ujZn0CCLBJxXkHTJ+D15MMOdZJKQ
         cu7yBOCvIiFWEmRrWD6gLNlybuF4YwSowxSRKAvP8uDoeUGN8KFYK8VKfWT/KjUch0qD
         meSj2/03F4pWrodJoWu9K39+wdRMtOXKI1bjCV/5bw6iGjpxmQdhglmGIbWjd2cQUPti
         pZhDBLaoxAy7y0ZtDgMV0CRMMrkMAZ0Hr1KQa8C56LJEIV35GCiP3u2stKJnKh0gDVpZ
         rDxVRU/1A3PWz+IKPLYoj4SOPWCi3hfCwFlJOILSyl05kflgp0HatzUtOLD70duHRv3c
         4HWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788396762; x=1789001562;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PJgfeG9OkO77dXNQBRcYGcD7KsQqp8aI0V+XoArsabk=;
        b=HPXALNLVtSmAlSxa3jTtddZ3OkEC784KrlUaA/xAV+pgyG0TTzaFouUMCG4MMHn4lI
         Lm4XGy/t1VgP8svoSv71xnXu3JVjVu38VbfUso9uhkRpNJVj3ahzr2TzhhgDQXRpWMDa
         +JPNszEgUILuQGI6NdqDV9Y0G5P/q2QJwYu9cIP1KCOknNmPG0hJu2nIX/PFc/ZkYVGX
         a63Bfj9Age/24Qz19YCc7gNmU60xdMnuizqwwPh7GqQMWm+1TOkBXUXQqtsC0tDC3xO4
         ugWo/6RXM8c4z8KWgzyOX0aYo23a8XxMYoaQ9hMsI+IHd6DJi3XTHjo7/WAOjCQ/IdBY
         1RHg==
X-Gm-Message-State: AFuF++n/CI+J9RQdcnzKJGTCRjYGJ4G7E2eFOMwIZmC/9MfFs5vFNwY9
	z++DD92+ccw2hHo3X4TbOGt9P7UXqmDFr1W0Y1PyIJMuv19FGJPyTlsIPaouxsim2oU=
X-Gm-Gg: AYBFou1Is8uy+kmMwGbtTbHkUk5X1FYUuRKi/hw8qfuR8LX3liUysDI8dEynqF8mOUJ
	46L9zwXFsYX7tyYmwsZEQXs/7GcD1JI8Lp93DkaPXRxzULS1KknmZrGWqT4KiAZuDVHUGQ6AcVU
	fU4Ut4aJctvek3tlEKXL2WyzRwsEcOUp/AgqQ8GLOwYX9h33SQlVoD47rAMDB9y4LpiRuNHoSf8
	yhtJEAHOSQulUcm4m+i70FfTMyUtaGl1GhtnY7ODAVUO8VQK3WawB7F55MzJLVrOPLs2R5JCNp4
	BVHNJEYM74fKiXNiu76L16cB6h6JXQoDO+5LcgQGQRUunpF2VgdHib8MZdD+uJOeSFM+Ei8RLms
	P32OGje0/vxO+DGs7OV2wIxZD0hNaSQT/zIuFzrOwycxwKy+lAQBvVQKFSSBbhXZ+ziui1wZLMM
	d0v+4b6lh79rJGoB+7qY9KYpJvs8Gu8etgBrx2KFw1RLbpJ4q4Tj4F1Qkroyc3Qp5Oxs2jNP7qk
	NKcrqCW8v7LEADcoE/Ee2v4l40bbabDIiIvwJ9MCULVLa0iFLx6f1Y=
X-Received: by 2002:a05:622a:1906:b0:52d:918b:92e1 with SMTP id d75a77b69052e-53036b93351mr100930171cf.5.1788396761900;
        Wed, 02 Sep 2026 17:52:41 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530331dc460sm31323441cf.18.2026.09.02.17.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 17:52:41 -0700 (PDT)
Date: Wed, 2 Sep 2026 20:52:39 -0400
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, david@kernel.org, osalvador@suse.de, akpm@linux-foundation.org
Subject: Re: [PATCH] mm/memory_hotplug: factor out node_is_memoryless()
Message-ID: <apjESMmhP61ovLuu@gourry-fedora-PF4VCD3F>
References: <20260902195507.88655-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902195507.88655-1-gourry@gourry.net>

On Wed, Sep 02, 2026 at 03:55:07PM -0400, Gregory Price wrote:
> A memoryless node neither spans present pages (populated or ZONE_DEVICE)
> nor has an offline-but-added memory block still linked to it in sysfs.
> 
> try_offline_node() presently open-codes this memoryless check.
> 
> Pull that into a node_is_memoryless() helper and pull the existing
> check_no_memblock_for_node_cb() helper ahead of the add/online path
> so it's clearer what is happening here.
> 
> No functional change.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  mm/memory_hotplug.c | 60 +++++++++++++++++++++++----------------------
>  1 file changed, 31 insertions(+), 29 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 226ab9cb078ad..d0e94057682af 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1491,6 +1491,36 @@ static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
>  	return ret;
>  }
>  
> +static int check_no_memblock_for_node_cb(struct memory_block *mem, void *arg)
> +{
> +	int nid = *(int *)arg;
> +
> +	/*
> +	 * If a memory block belongs to multiple nodes, the stored nid is not
> +	 * reliable. However, such blocks are always online (e.g., cannot get
> +	 * offlined) and, therefore, are still spanned by the node.
> +	 */
> +	return mem->nid == nid ? -EEXIST : 0;
> +}
> +
> +/* Caller must hold the memory hotplug lock for this check. */
> +static bool node_is_memoryless(int nid)
> +{
> +	/*
> +	 * A node still spanning pages (especially ZONE_DEVICE) is not
> +	 * memoryless.  A node spans memory after move_pfn_range_to_zone(),
> +	 * e.g. once a memory block has been onlined.
> +	 */
> +	if (node_spanned_pages(nid))
> +		return false;

browsing sashiko feedback:

[Severity: High]
This is a pre-existing issue and was not introduced by this patch, but can
this lockless read of node_spanned_pages() race with ZONE_DEVICE memory
hotplug?

---

This seems legit and worth addressing (other notes are addressible as
well, but this is maybe noteworthy).

I actually have some old patches sandbagged that tried to marry the
ZONE_DEVICE hotplug pattern through mm/memory_hotplug.c rather than its
separare entry-point.  Might be worth a revisit.

I don't know that I want to predicate this particular fix on this patch
but it's worth a think.

~Gregory
