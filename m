Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41792641F8
	for <linux-cxl@vger.kernel.org>; Thu, 22 May 2025 08:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747902316; cv=none; b=aj7rtp3h+J3mKnXKMa46Vshs0PJ0bFvSS3KmYyN15vOa3ZvHlzCGzRMFLUdHanExCqRFEucT0OMDPnCig1Tjlgk/VdnAajGKW+vlMyXdUfQ9xsISvCBlsFQ6NMEsmW+6pVJq3jTKuPOtJBMRNrswfkeqkRuYqKFZXMHntkMzAfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747902316; c=relaxed/simple;
	bh=OkNspN0lwQgamJoo11x9Jt9RYlLgCLcuEvh6EAFBSyw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MUBjPGVh2tBOy46GR/J7C17e1B079oZEmNrIBaerJVV/lJ2iLgjjUJ61W0Tz7XOwGtcxRQZ7+nmmtZdzr2Q7nd7AjRnD8maxI+OL67W4VJ151hgncGdUJCIk3ab+UgPrSRdO/t+21lVYWD/aZ8waXkR7jmC+OSbWbzRA2+55Thg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b31Xs1N9Yz6GDKP;
	Thu, 22 May 2025 16:24:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9370B140142;
	Thu, 22 May 2025 16:25:08 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 22 May
 2025 10:25:08 +0200
Date: Thu, 22 May 2025 09:25:11 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH] cxl/features: Remove the inline specifier from
 to_cxlfs()
Message-ID: <20250522092511.0000690b@huawei.com>
In-Reply-To: <20250521233625.1745849-1-alison.schofield@intel.com>
References: <20250521233625.1745849-1-alison.schofield@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 21 May 2025 16:36:23 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> to_cxlfs() was declared 'inline' in the header but only defined in
> drivers/cxl/core/features.c. This has worked because features.c was
> the only file using the function and the definition happened to be
> available in the same compilation unit.
> 
> However, in preparation for a second .c file using the header and
> needing to call the function, the inline specifier became an issue.
> Sparse flagged the declaration as invalid since 'inline' requires a
> visible definition at the point of use.
> 
> Defining the function in the header was considered but rejected, as
> it depends on internal symbols not visible at that level.
> 
> Remove the inline specifier to correct the linkage violation.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks for the quick turn around.

> ---
> 
> I intentionally did not add a Fixes Tag at the point this was
> introduced because there is no breakage until the second user
> comes along. 
> 
> The second user is this patchset being reviewed:
> [PATCH v6 0/8] cxl: support CXL memory RAS features
> https://lore.kernel.org/linux-cxl/20250521124749.817-1-shiju.jose@huawei.com/
> 
> 
>  drivers/cxl/core/features.c | 2 +-
>  include/cxl/features.h      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 1498e2369c37..efe88c043227 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -36,7 +36,7 @@ static bool is_cxl_feature_exclusive(struct cxl_feat_entry *entry)
>  	return is_cxl_feature_exclusive_by_uuid(&entry->uuid);
>  }
>  
> -inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds)
> +struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds)
>  {
>  	return cxlds->cxlfs;
>  }
> diff --git a/include/cxl/features.h b/include/cxl/features.h
> index 5f7f842765a5..b9297693dae7 100644
> --- a/include/cxl/features.h
> +++ b/include/cxl/features.h
> @@ -64,7 +64,7 @@ struct cxl_features_state {
>  struct cxl_mailbox;
>  struct cxl_memdev;
>  #ifdef CONFIG_CXL_FEATURES
> -inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds);
> +struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds);
>  int devm_cxl_setup_features(struct cxl_dev_state *cxlds);
>  int devm_cxl_setup_fwctl(struct device *host, struct cxl_memdev *cxlmd);
>  #else
> 
> base-commit: 92a09c47464d040866cf2b4cd052bc60555185fb

