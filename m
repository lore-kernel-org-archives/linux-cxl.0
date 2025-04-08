Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC937137C37;
	Tue,  8 Apr 2025 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744120327; cv=none; b=OIKOz60PEi0ZfHmWCMujWKpv2Yct8r4bR7jOtqkmj4SJfJXml95M6FGYyUCuN2HabKMMcPMNixGRJnSa6BCXkKCErgy/Io+06aH3BfZk7rG37VYTPp+w5xoS0iNmQ/Kk2hJ1yrv4AG7uHxagjBrJB7Kb+0B47VoYjlE+Zjb3yrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744120327; c=relaxed/simple;
	bh=HaGFEf+YwVPYiVCfx8DFFA6TjICSQuB/1KMbhZ4PLbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BuztOVnFiKYTpaO7bozzTNHcizkhQcR5LWtbH1/5hHMgjAXCIef26lWCmTnstZ8KSNfkK1S20rAUj6qyFqx3Yuy+uHF9omre9iqpHd5TqybZXDezg5A8UrRj7rkMBaxWYrfbXnUs7wB/WRDP1DB1NMATTbCtP01qor8GxpR3oQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJnyNNxi; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJnyNNxi"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e6dd991a0e6so4829893276.1;
        Tue, 08 Apr 2025 06:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744120325; x=1744725125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iggtIaOdKwCaj0c8UnJKvVOsn69XQmtF4Ox/sMEh3ho=;
        b=GJnyNNxiNL5hGLIV//Sh4tDN2nxnrTmx1QAznEf23QzYIJ9HAJBn1C05Q21FExs0+6
         jv8q4Yq6txHqOz02afX2cTbedubO14xNqJbqMbahmyeR3T6wKLIXmgno+susx4PTxEv5
         jdCpmMoClPsDXMCYU9BOMJGkPEeJGY3kEa5TElx8xJ/tnZ5DoGoIjtBqeXrAhbQWZUrB
         lxUxF5h6udySek915EPAWYe2IwWd6n2TJ0f/yguY+PwcG8JP7dUumgDmdNwrocEimXIs
         T/BT9Y3uaORJsw0HCj4XXdPm51LtNgmUFatMF0VzF4llHBUHbzjYtSIfc+9ciIHAm0oZ
         ISkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744120325; x=1744725125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iggtIaOdKwCaj0c8UnJKvVOsn69XQmtF4Ox/sMEh3ho=;
        b=BNYdNVxzPsYLI6oQDezHEvq9LjKnJIBHBo2SG7qf260OMp3Exaf7JgYBJqwHqCwLRc
         fqfeSniYaC/7DOYVDQ8teId9FO/QRs2GnBE5iEjxi6AwLYzlrozT8jvvj5OEnzyTMzpA
         GXZBSdwur/LQ6sHXsJvNLHSzxyzsyWSzz7MclPT8kwJLX6DqIDQ9/qc4Xuxt71neuAXM
         4pz3Kj33orWTThkxlhLUdaEsL2fCVDzdCj+7YpGSWtwgR9F6JxiRRKlWIHuS82vN2Cv6
         uRhr5cSyFJq6eKrhAPMhNpYsl/f35r0obQ62HbW+c0JSPk58sV84oY8z/dGiyGy5IJYa
         JQmA==
X-Forwarded-Encrypted: i=1; AJvYcCWGX4TmRwD6nB+M1vDJudN4QuphVa/8H6Fy3Vle7PG37Cy2noFNYRzY0jlhqHBcoiHgjbwOav+OURA=@vger.kernel.org, AJvYcCX/MCOW4UWicRFJuvWOB+Z3QUsTbr4dRevSmAF2ig5fllWY7stYoKMRifzVMv9qMoTt0/R+thlmvTcTOsFe@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2WlBRmVn8vkAfKJASitAUsK2uxNHe/c9y13v86MOtieecxpnQ
	I6qD8yS3sZJrEdYxJK61vPKVSUG7WTTpYk7dR7zfzu86FjaG8VwA
X-Gm-Gg: ASbGncviROPganRqbN/Nn7Zi+VlB9u9YGUxEbeTY7owQSZj/yTq3q3gNRHYjS8VPzFm
	F4f4c0gdjJam+xQSyqeDkwIDNwRgasuASXcMrixarqs3Ahf6JDtCxhDvsNILT76SC3eaizEDRf2
	vcCFFklKvzpT7xWJ46xMm6vHWKoBxrKEjMgxzRY3iQ0FMgklJyROKWF6o8Miy0R0e1JBgLiAxNo
	hJQ9KNyuP32GZvxLZe7q5duKfUXVIP2irWuq8mlmpQqm98iPzDcWvNe1O6MfYYElbCuN+QSnZo8
	PgaYturyYdp0A7WJZlBuQWykudkIqIdmKrVZgjpK
X-Google-Smtp-Source: AGHT+IEEOIFV5JW5y4gJNyzsPGTfIpKDTk2nVR3Zxvi/DZjydcsNnJirWV6ukyAOhPkuSSu+3YtRSQ==
X-Received: by 2002:a05:6902:2e0a:b0:e6d:f7ea:c722 with SMTP id 3f1490d57ef6-e6e1c286d11mr28221779276.17.1744120324656;
        Tue, 08 Apr 2025 06:52:04 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e6e0ca96a08sm2853800276.45.2025.04.08.06.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 06:52:04 -0700 (PDT)
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
Subject: Re: [PATCH v7 3/3] mm/mempolicy: Support memory hotplug in weighted interleave
Date: Tue,  8 Apr 2025 06:52:01 -0700
Message-ID: <20250408135202.3001047-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250408073243.488-4-rakie.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  8 Apr 2025 16:32:42 +0900 Rakie Kim <rakie.kim@sk.com> wrote:

Hi Rakie,

Looks good to me as well : -) Thank you for working on this!

Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

> The weighted interleave policy distributes page allocations across multiple
> NUMA nodes based on their performance weight, thereby improving memory
> bandwidth utilization. The weight values for each node are configured
> through sysfs.
> 
> Previously, sysfs entries for configuring weighted interleave were created
> for all possible nodes (N_POSSIBLE) at initialization, including nodes that
> might not have memory. However, not all nodes in N_POSSIBLE are usable at
> runtime, as some may remain memoryless or offline.
> This led to sysfs entries being created for unusable nodes, causing
> potential misconfiguration issues.
> 
> To address this issue, this patch modifies the sysfs creation logic to:
> 1) Limit sysfs entries to nodes that are online and have memory, avoiding
>    the creation of sysfs entries for nodes that cannot be used.
> 2) Support memory hotplug by dynamically adding and removing sysfs entries
>    based on whether a node transitions into or out of the N_MEMORY state.
> 
> Additionally, the patch ensures that sysfs attributes are properly managed
> when nodes go offline, preventing stale or redundant entries from persisting
> in the system.
> 
> By making these changes, the weighted interleave policy now manages its
> sysfs entries more efficiently, ensuring that only relevant nodes are
> considered for interleaving, and dynamically adapting to memory hotplug
> events.
> 
> Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/mempolicy.c | 106 ++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 83 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 988575f29c53..9aa884107f4c 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -113,6 +113,7 @@
>  #include <asm/tlbflush.h>
>  #include <asm/tlb.h>
>  #include <linux/uaccess.h>
> +#include <linux/memory.h>
>  
>  #include "internal.h"
>  
> @@ -3421,6 +3422,7 @@ struct iw_node_attr {
>  
>  struct sysfs_wi_group {
>  	struct kobject wi_kobj;
> +	struct mutex kobj_lock;
>  	struct iw_node_attr *nattrs[];
>  };
>  
> @@ -3470,13 +3472,24 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
>  
>  static void sysfs_wi_node_delete(int nid)
>  {
> -	if (!wi_group->nattrs[nid])
> +	struct iw_node_attr *attr;
> +
> +	if (nid < 0 || nid >= nr_node_ids)
> +		return;
> +
> +	mutex_lock(&wi_group->kobj_lock);
> +	attr = wi_group->nattrs[nid];
> +	if (!attr) {
> +		mutex_unlock(&wi_group->kobj_lock);
>  		return;
> +	}
> +
> +	wi_group->nattrs[nid] = NULL;
> +	mutex_unlock(&wi_group->kobj_lock);
>  
> -	sysfs_remove_file(&wi_group->wi_kobj,
> -			  &wi_group->nattrs[nid]->kobj_attr.attr);
> -	kfree(wi_group->nattrs[nid]->kobj_attr.attr.name);
> -	kfree(wi_group->nattrs[nid]);
> +	sysfs_remove_file(&wi_group->wi_kobj, &attr->kobj_attr.attr);
> +	kfree(attr->kobj_attr.attr.name);
> +	kfree(attr);
>  }
>  
>  static void sysfs_wi_release(struct kobject *wi_kobj)
> @@ -3495,35 +3508,77 @@ static const struct kobj_type wi_ktype = {
>  
>  static int sysfs_wi_node_add(int nid)
>  {
> -	struct iw_node_attr *node_attr;
> +	int ret = 0;
>  	char *name;
> +	struct iw_node_attr *new_attr = NULL;
>  
> -	node_attr = kzalloc(sizeof(*node_attr), GFP_KERNEL);
> -	if (!node_attr)
> +	if (nid < 0 || nid >= nr_node_ids) {
> +		pr_err("Invalid node id: %d\n", nid);
> +		return -EINVAL;
> +	}
> +
> +	new_attr = kzalloc(sizeof(struct iw_node_attr), GFP_KERNEL);
> +	if (!new_attr)
>  		return -ENOMEM;
>  
>  	name = kasprintf(GFP_KERNEL, "node%d", nid);
>  	if (!name) {
> -		kfree(node_attr);
> +		kfree(new_attr);
>  		return -ENOMEM;
>  	}
>  
> -	sysfs_attr_init(&node_attr->kobj_attr.attr);
> -	node_attr->kobj_attr.attr.name = name;
> -	node_attr->kobj_attr.attr.mode = 0644;
> -	node_attr->kobj_attr.show = node_show;
> -	node_attr->kobj_attr.store = node_store;
> -	node_attr->nid = nid;
> +	mutex_lock(&wi_group->kobj_lock);
> +	if (wi_group->nattrs[nid]) {
> +		mutex_unlock(&wi_group->kobj_lock);
> +		pr_info("Node [%d] already exists\n", nid);
> +		kfree(new_attr);
> +		kfree(name);
> +		return 0;
> +	}
> +	wi_group->nattrs[nid] = new_attr;
>  
> -	if (sysfs_create_file(&wi_group->wi_kobj, &node_attr->kobj_attr.attr)) {
> -		kfree(node_attr->kobj_attr.attr.name);
> -		kfree(node_attr);
> -		pr_err("failed to add attribute to weighted_interleave\n");
> -		return -ENOMEM;
> +	sysfs_attr_init(&wi_group->nattrs[nid]->kobj_attr.attr);
> +	wi_group->nattrs[nid]->kobj_attr.attr.name = name;
> +	wi_group->nattrs[nid]->kobj_attr.attr.mode = 0644;
> +	wi_group->nattrs[nid]->kobj_attr.show = node_show;
> +	wi_group->nattrs[nid]->kobj_attr.store = node_store;
> +	wi_group->nattrs[nid]->nid = nid;
> +
> +	ret = sysfs_create_file(&wi_group->wi_kobj,
> +				&wi_group->nattrs[nid]->kobj_attr.attr);
> +	if (ret) {
> +		kfree(wi_group->nattrs[nid]->kobj_attr.attr.name);
> +		kfree(wi_group->nattrs[nid]);
> +		wi_group->nattrs[nid] = NULL;
> +		pr_err("Failed to add attribute to weighted_interleave: %d\n", ret);
>  	}
> +	mutex_unlock(&wi_group->kobj_lock);
>  
> -	wi_group->nattrs[nid] = node_attr;
> -	return 0;
> +	return ret;
> +}
> +
> +static int wi_node_notifier(struct notifier_block *nb,
> +			       unsigned long action, void *data)
> +{
> +	int err;
> +	struct memory_notify *arg = data;
> +	int nid = arg->status_change_nid;
> +
> +	if (nid < 0)
> +		return NOTIFY_OK;
> +
> +	switch(action) {
> +	case MEM_ONLINE:
> +		err = sysfs_wi_node_add(nid);
> +		if (err)
> +			pr_err("failed to add sysfs [node%d]\n", nid);
> +		break;
> +	case MEM_OFFLINE:
> +		sysfs_wi_node_delete(nid);
> +		break;
> +	}
> +
> +	return NOTIFY_OK;
>  }
>  
>  static int __init add_weighted_interleave_group(struct kobject *mempolicy_kobj)
> @@ -3534,13 +3589,17 @@ static int __init add_weighted_interleave_group(struct kobject *mempolicy_kobj)
>  			   GFP_KERNEL);
>  	if (!wi_group)
>  		return -ENOMEM;
> +	mutex_init(&wi_group->kobj_lock);
>  
>  	err = kobject_init_and_add(&wi_group->wi_kobj, &wi_ktype, mempolicy_kobj,
>  				   "weighted_interleave");
>  	if (err)
>  		goto err_put_kobj;
>  
> -	for_each_node_state(nid, N_POSSIBLE) {
> +	for_each_online_node(nid) {
> +		if (!node_state(nid, N_MEMORY))
> +			continue;
> +
>  		err = sysfs_wi_node_add(nid);
>  		if (err) {
>  			pr_err("failed to add sysfs [node%d]\n", nid);
> @@ -3548,6 +3607,7 @@ static int __init add_weighted_interleave_group(struct kobject *mempolicy_kobj)
>  		}
>  	}
>  
> +	hotplug_memory_notifier(wi_node_notifier, DEFAULT_CALLBACK_PRI);
>  	return 0;
>  
>  err_del_kobj:
> -- 
> 2.34.1

Sent using hkml (https://github.com/sjp38/hackermail)

