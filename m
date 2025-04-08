Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D4A1ADC83;
	Tue,  8 Apr 2025 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744120176; cv=none; b=rZmTm/8DLr2zhghlmFt6rX6cspop5AVTEWhhg7coxU40PeKuR/xNx5w3AJIsvTpCzvpeAXRnmGwc4xrXNgD9NJPR9VwHUJkbj1gHIND6WsCELUL67XywYiTaKSq3UMqFgBJoDkzXgsbHlZJzI6OidpnOBENXw6HSZeiv/Hih6M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744120176; c=relaxed/simple;
	bh=0ZQKRssJ93hCQOX/jX1fsoONV8oJ2yuBNwmUrm0kM4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTI8KvVk5JTmtcnyOhXjV62wZwY8Jf/7MAulXUG+f0QtiNyPqvwO5NxcUBfe0BemZlucOMt+htY4GxEfZAODpYzgCGyw+Q83ePL8KKfHsKr6lRweqo47/5tMOlq6b5K6RFe4LreeCnFsUdsMFq84L1JWz005/foOtZoH8BdShpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwbbtrQa; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwbbtrQa"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e6405e4ab4dso5900462276.0;
        Tue, 08 Apr 2025 06:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744120174; x=1744724974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6roUkAtO7CHIJtMo8g3NkkIj2dqhMEED9ifNn9GTILs=;
        b=WwbbtrQaKzvHo6vgaIip9hfygsO+6KSwc/jLW7Tc6u2fclBeBLx0vU4Owxttpvx51n
         8OmJRcoYMVkVDSIDlU8DSu+B0et8d4BBpDqCFQOckSGght1KuhO4aUXqErjACKiGlRSN
         aGmnoubO6nYs1CczvXtjITijsmqMKxfTIC/BAsb9GCBeAbGUb2s1EjEQAvq0uFLBMXHK
         Q9NKqt3G0kmHQJu7SgJ/CJWHOp6hkiBErOMOxIpTxRQtIOxaHR6Gi3xGvJ3pEA4GiFaB
         vvfLs60yqf6pod3tYmo3SfPMsublCWHFlwEjwgcxCB8hhMmrmzPCUJXxsHOiClraVlz+
         chsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744120174; x=1744724974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6roUkAtO7CHIJtMo8g3NkkIj2dqhMEED9ifNn9GTILs=;
        b=NiCASV+GmRQSExPCNxtq4T37ZceCkoop+2HQL/we1MjmW8uOZJblMaz4fkXB7GvPtF
         ed8GU4SREeuf/7z7dWknN+VG4KseoFdKQgpya32MJLIhYu45B0aPipdUaXn048gITgWS
         OHyHW6WvMewozRHAl3ux3fkhAagboxpSs/HTvT5t45e8QU2GJg2jYGgwK7SHSUyn+0ba
         gIO6FXpJ+o7TcCIrGabhfcApgkvgLZmNOHPGJht4X9MBz24YfJzMEkn8dqdZt1XiTVs+
         sukhuBAgty5XVB3YLRrYiAbiRjmJzTJHWMxjavKvF20//WTEdxGUGpXDFmbBeCq3iWcU
         HnMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU7RFr8t4ssUiSkB5YMr+KZRkBA9taQGpPYQsn/ZiUc/h4vqnIRhUgQmeChOgUqtCY6xR9yfYoIgw=@vger.kernel.org, AJvYcCXXWQJgqMON3ZlsY5L+qwo7zjPqYNizBjuZsJ988WhgvMtq277hO/y2GL/dVoJMLTYlPRr6BDq/QtM/9vUB@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf4T9nUN3slR6mzGZXptMQ0SfwYGTtvUqm4KkiRUlZIDcGOW4C
	StkMGBJo2ALM0/aX74T6Fk3vkDkV7+P1SmXhw9ImeMo2fN/kQ33o
X-Gm-Gg: ASbGncsTbJLkjnXBBGT0n1BPrJwbte7DfzS+cChKdpASYdEGccMXGMmtu1B0TZuj2N9
	1hJfHvGDC+qfOGaDFvZ2TLEUoRAdoRMPLeC3Gv03LtVZT6JXYB8yRMIijaQM40qyzvYscOC4KSE
	gtstGszxxHVi4pakrRiDG5InOqZnJ8U87n1I+MTxed/Jda9kLKyvjJzhZ0FoGzt57bvo6ZbcYOB
	Fr2hKGt23vb7Ob03AaIxPpSVJKzBZ1bRtf636P5OTYEIKPKD1czIsCMRK1DW3L0leQ7EBepD/3A
	ezMl6Xh5dp+ZR7ODeS0LuAqbBtJzS0DavajJpa38dtgE
X-Google-Smtp-Source: AGHT+IH8QJ49ySf1MDM3STQQAFouuIhVkERvHQyB9mCSnm4/qtjQlXpAGs8+hfQWwIM74A4i6u9mCg==
X-Received: by 2002:a05:690c:6111:b0:703:b47a:7312 with SMTP id 00721157ae682-7042d51dad4mr60029507b3.15.1744120173954;
        Tue, 08 Apr 2025 06:49:33 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:71::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-703d1e4d90bsm31055437b3.32.2025.04.08.06.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 06:49:33 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org,
	gourry@gourry.net,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	david@redhat.com,
	Jonathan.Cameron@huawei.com,
	osalvador@suse.de,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com
Subject: Re: [PATCH v7 2/3] mm/mempolicy: Prepare weighted interleave sysfs for memory hotplug
Date: Tue,  8 Apr 2025 06:49:30 -0700
Message-ID: <20250408134932.2986280-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250408073243.488-3-rakie.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  8 Apr 2025 16:32:41 +0900 Rakie Kim <rakie.kim@sk.com> wrote:

Hi Rakie,
This also looks good to me!

Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

> Previously, the weighted interleave sysfs structure was statically
> managed during initialization. This prevented new nodes from being
> recognized when memory hotplug events occurred, limiting the ability
> to update or extend sysfs entries dynamically at runtime.
> 
> To address this, this patch refactors the sysfs infrastructure and
> encapsulates it within a new structure, `sysfs_wi_group`, which holds
> both the kobject and an array of node attribute pointers.
> 
> By allocating this group structure globally, the per-node sysfs
> attributes can be managed beyond initialization time, enabling
> external modules to insert or remove node entries in response to
> events such as memory hotplug or node online/offline transitions.
> 
> Instead of allocating all per-node sysfs attributes at once, the
> initialization path now uses the existing sysfs_wi_node_add() and
> sysfs_wi_node_delete() helpers. This refactoring makes it possible
> to modularly manage per-node sysfs entries and ensures the
> infrastructure is ready for runtime extension.
> 
> Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> ---
>  mm/mempolicy.c | 61 ++++++++++++++++++++++++--------------------------
>  1 file changed, 29 insertions(+), 32 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 0da102aa1cfc..988575f29c53 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -3419,6 +3419,13 @@ struct iw_node_attr {
>  	int nid;
>  };
>  
> +struct sysfs_wi_group {
> +	struct kobject wi_kobj;
> +	struct iw_node_attr *nattrs[];
> +};
> +
> +static struct sysfs_wi_group *wi_group;
> +
>  static ssize_t node_show(struct kobject *kobj, struct kobj_attribute *attr,
>  			 char *buf)
>  {
> @@ -3461,27 +3468,24 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
>  	return count;
>  }
>  
> -static struct iw_node_attr **node_attrs;
> -
> -static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
> -				  struct kobject *parent)
> +static void sysfs_wi_node_delete(int nid)
>  {
> -	if (!node_attr)
> +	if (!wi_group->nattrs[nid])
>  		return;
> -	sysfs_remove_file(parent, &node_attr->kobj_attr.attr);
> -	kfree(node_attr->kobj_attr.attr.name);
> -	kfree(node_attr);
> +
> +	sysfs_remove_file(&wi_group->wi_kobj,
> +			  &wi_group->nattrs[nid]->kobj_attr.attr);
> +	kfree(wi_group->nattrs[nid]->kobj_attr.attr.name);
> +	kfree(wi_group->nattrs[nid]);
>  }
>  
>  static void sysfs_wi_release(struct kobject *wi_kobj)
>  {
> -	int i;
> -
> -	for (i = 0; i < nr_node_ids; i++)
> -		sysfs_wi_node_release(node_attrs[i], wi_kobj);
> +	int nid;
>  
> -	kfree(node_attrs);
> -	kfree(wi_kobj);
> +	for (nid = 0; nid < nr_node_ids; nid++)
> +		sysfs_wi_node_delete(nid);
> +	kfree(wi_group);
>  }
>  
>  static const struct kobj_type wi_ktype = {
> @@ -3489,7 +3493,7 @@ static const struct kobj_type wi_ktype = {
>  	.release = sysfs_wi_release,
>  };
>  
> -static int add_weight_node(int nid, struct kobject *wi_kobj)
> +static int sysfs_wi_node_add(int nid)
>  {
>  	struct iw_node_attr *node_attr;
>  	char *name;
> @@ -3511,40 +3515,33 @@ static int add_weight_node(int nid, struct kobject *wi_kobj)
>  	node_attr->kobj_attr.store = node_store;
>  	node_attr->nid = nid;
>  
> -	if (sysfs_create_file(wi_kobj, &node_attr->kobj_attr.attr)) {
> +	if (sysfs_create_file(&wi_group->wi_kobj, &node_attr->kobj_attr.attr)) {
>  		kfree(node_attr->kobj_attr.attr.name);
>  		kfree(node_attr);
>  		pr_err("failed to add attribute to weighted_interleave\n");
>  		return -ENOMEM;
>  	}
>  
> -	node_attrs[nid] = node_attr;
> +	wi_group->nattrs[nid] = node_attr;
>  	return 0;
>  }
>  
> -static int add_weighted_interleave_group(struct kobject *root_kobj)
> +static int __init add_weighted_interleave_group(struct kobject *mempolicy_kobj)
>  {
> -	struct kobject *wi_kobj;
>  	int nid, err;
>  
> -	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
> -			     GFP_KERNEL);
> -	if (!node_attrs)
> +	wi_group = kzalloc(struct_size(wi_group, nattrs, nr_node_ids),
> +			   GFP_KERNEL);
> +	if (!wi_group)
>  		return -ENOMEM;
>  
> -	wi_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
> -	if (!wi_kobj) {
> -		kfree(node_attrs);
> -		return -ENOMEM;
> -	}
> -
> -	err = kobject_init_and_add(wi_kobj, &wi_ktype, root_kobj,
> +	err = kobject_init_and_add(&wi_group->wi_kobj, &wi_ktype, mempolicy_kobj,
>  				   "weighted_interleave");
>  	if (err)
>  		goto err_put_kobj;
>  
>  	for_each_node_state(nid, N_POSSIBLE) {
> -		err = add_weight_node(nid, wi_kobj);
> +		err = sysfs_wi_node_add(nid);
>  		if (err) {
>  			pr_err("failed to add sysfs [node%d]\n", nid);
>  			goto err_del_kobj;
> @@ -3554,9 +3551,9 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
>  	return 0;
>  
>  err_del_kobj:
> -	kobject_del(wi_kobj);
> +	kobject_del(&wi_group->wi_kobj);
>  err_put_kobj:
> -	kobject_put(wi_kobj);
> +	kobject_put(&wi_group->wi_kobj);
>  	return err;
>  }
>  
> -- 
> 2.34.1

Sent using hkml (https://github.com/sjp38/hackermail)

