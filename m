Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77675634
	for <linux-cxl@vger.kernel.org>; Fri,  4 Apr 2025 20:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743799513; cv=none; b=XgLmeElnGw+wiyTLspKX4zUazP+Aq2DbNE7sBfbn6L2YfLID/jmeI+knokgDfbGuwAgsJXzjse0CUvE9xTdn/s4migK63+JtbrpL08UJKoUQlrfCR5vXOY5q1EZBdUOYsncpw9TVrE4fL2jrAkhzcAF8OO3nx8KIgVgDPYgyNyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743799513; c=relaxed/simple;
	bh=A/0jVxgGdOjNBCbM5Z5ihTLkQLzDOgDfPXKDmfO2yMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YHJdjeKDb2MliBLqH5TkY3L6O52gNt3QOyeefN18Dd1gx11zl9rWktiqtLFGToo4NuGrQLyyePmRcD9qui7au5a2Ih65OPo873vhu58J4wvd+5/V4EuiAiVgU+lTOAjDefiPNFemM4xUmmNTjSUPfCKxyJNN2Gx6IMMsFgmKmjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YDwwjNrG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YDwwjNrG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743799509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=U911cPDWIO1xJUhHQ77TZZ5y+lwqBdTdthchIsy3sAI=;
	b=YDwwjNrGgpLT8nho9ptxgIJG0Ni7EYhic0xZrSFbqDErfzMHslkWywHXlknnKu47rHP/S4
	qKg0dmXqME/ZrMFsJI8lpEgHmzGB98YDVZ1ZINy3sBrTUvwSQZct/Xd+pLGvfGtr8/cWro
	XoRzPI2X2lbCIBtFYm6AL8r6D9AhyUo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-Gti6DzERNGeNBRN91DSPyA-1; Fri, 04 Apr 2025 16:45:06 -0400
X-MC-Unique: Gti6DzERNGeNBRN91DSPyA-1
X-Mimecast-MFC-AGG-ID: Gti6DzERNGeNBRN91DSPyA_1743799505
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d3b211d0eso18304095e9.1
        for <linux-cxl@vger.kernel.org>; Fri, 04 Apr 2025 13:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743799505; x=1744404305;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U911cPDWIO1xJUhHQ77TZZ5y+lwqBdTdthchIsy3sAI=;
        b=NlZDYWlcubKR4RFdbPYRitAQEu1eVmPNER1iQDUhC88ET5DLyAdBN4dHxPLnX50a1s
         DulP4+HsDT0YOruYCq93ouqf5zuMGy6eLMH492O47WAexZX8ldgSQlhhxY9qr9YycANv
         /Hl2frBFn9mHkRxeBVNOtAKzoY+/c6FbXUrJkMcPmyTBRF1LOe7su88bM5Tb2quglyc3
         IWtHIyG8+INy1kVbX04Cxaig7+yHJTHaAAVpe50mYxPSd1Z5pyYktAkwQFLCgY0fxqZC
         /ZviTFhdQyb+55/nMZ8p9shniwUAW+T5iNwxOkKZY8Z5bmRunxJjhZxKPkjmcPNl+bEm
         lqIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5o4xLl0nGVgEgyWBHSqsGXC0RRuuy1OSpxPqwXPH3D8iik8PPqw/0hko5jW7Cqnth9Bom/xiziuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YysjhcHIUefZuF1XpdLHW0+wt+IpXJuZWpE9Fh46Al2PBEer3Qy
	05n0E/mOK8jvOXE//cM3AFoydOmlHb7craIqjM1ivvidQjbF8uliPd2du34tcau7mPf289PPIZw
	5hetITRPHTX8HNdy3+VbLlkOyiXOhOfCOjjzuDrE56C+weTWnsIOBuly17A==
X-Gm-Gg: ASbGncuE1hkTcFb0z7yoAwH+epQgbotIhp9AxqZmoPyoPrmRlyz/7Vcsn1DmZjO3vnj
	fnsl+2wqk9/BlW1puAwvDBqY4JAzeIUDF2oCb1GymwBGjw6K7vFXkywEsTYTC3jZ0CHrRNfhnKF
	0UIxcw6kTC3dX7ILSmDVEA6gKuMQTIx+iANnPsoY45iozQprdveLL8dg0xp6K66cjSTYo9lCOyM
	frMpRosp9paQ/q1D2erLAvabRcjF6wSnRnPAzXOQg8PDaZ7s9/PF50pN2GCqaHfzgHzFMe2mJIK
	qCh9lBlmV3snnMIlMnt4RmN1UdUMWL3/RKIlQK5ncto9Sg==
X-Received: by 2002:a05:600c:c0e:b0:439:8878:5029 with SMTP id 5b1f17b1804b1-43eced669f7mr41253995e9.2.1743799504748;
        Fri, 04 Apr 2025 13:45:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQdUlioKPZq69TbGGBY7RSLQ7tkW3z14eLyNXyqdvzkvKmN0qyRYhTKqjHqJuBvkjX3gnZ7Q==
X-Received: by 2002:a05:600c:c0e:b0:439:8878:5029 with SMTP id 5b1f17b1804b1-43eced669f7mr41253765e9.2.1743799504278;
        Fri, 04 Apr 2025 13:45:04 -0700 (PDT)
Received: from [192.168.3.141] (p4ff23dc9.dip0.t-ipconnect.de. [79.242.61.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34bbd9csm54659795e9.20.2025.04.04.13.45.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 13:45:03 -0700 (PDT)
Message-ID: <198f2cbe-b1cb-4239-833e-9aac33d978fa@redhat.com>
Date: Fri, 4 Apr 2025 22:45:00 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] mm/mempolicy: Support memory hotplug in weighted
 interleave
To: Rakie Kim <rakie.kim@sk.com>, akpm@linux-foundation.org
Cc: gourry@gourry.net, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, joshua.hahnjy@gmail.com,
 dan.j.williams@intel.com, ying.huang@linux.alibaba.com,
 Jonathan.Cameron@huawei.com, osalvador@suse.de, kernel_team@skhynix.com,
 honggyu.kim@sk.com, yunjeong.mun@sk.com
References: <20250404074623.1179-1-rakie.kim@sk.com>
 <20250404074623.1179-4-rakie.kim@sk.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250404074623.1179-4-rakie.kim@sk.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wJZ1h-CqCCfTRpoqsjtKG6AVaUwLlvrj2-Fgcd9om50_1743799505
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.04.25 09:46, Rakie Kim wrote:
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
>     the creation of sysfs entries for nodes that cannot be used.
> 2) Support memory hotplug by dynamically adding and removing sysfs entries
>     based on whether a node transitions into or out of the N_MEMORY state.
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
> ---
>   mm/mempolicy.c | 109 ++++++++++++++++++++++++++++++++++++++-----------
>   1 file changed, 86 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 73a9405ff352..f25c2c7f8fcf 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -113,6 +113,7 @@
>   #include <asm/tlbflush.h>
>   #include <asm/tlb.h>
>   #include <linux/uaccess.h>
> +#include <linux/memory.h>
>   
>   #include "internal.h"
>   
> @@ -3390,6 +3391,7 @@ struct iw_node_attr {
>   
>   struct sysfs_wi_group {
>   	struct kobject wi_kobj;
> +	struct mutex kobj_lock;
>   	struct iw_node_attr *nattrs[];
>   };
>   
> @@ -3439,13 +3441,24 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
>   
>   static void sysfs_wi_node_delete(int nid)
>   {
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
>   		return;
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
>   }
>   
>   static void sysfs_wi_release(struct kobject *wi_kobj)
> @@ -3464,35 +3477,80 @@ static const struct kobj_type wi_ktype = {
>   
>   static int sysfs_wi_node_add(int nid)
>   {
> -	struct iw_node_attr *node_attr;
> +	int ret = 0;
>   	char *name;
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
>   		return -ENOMEM;
>   
>   	name = kasprintf(GFP_KERNEL, "node%d", nid);
>   	if (!name) {
> -		kfree(node_attr);
> +		kfree(new_attr);
>   		return -ENOMEM;
>   	}
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
>   	}
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
> +		goto notifier_end;
> +
> +	switch(action) {
> +	case MEM_ONLINE:

MEM_ONLINE is too late, we cannot fail hotplug at that point.

Would MEM_GOING_ONLINE / MEM_CANCEL_ONLINE be better?


> +		err = sysfs_wi_node_add(nid);
> +		if (err) {
> +			pr_err("failed to add sysfs [node%d]\n", nid);
> +			return NOTIFY_BAD;

Note that NOTIFY_BAD includes NOTIFY_STOP_MASK. So you wouldn't call 
other notifiers, but the overall memory onlining would succeed, which is 
bad.

If we don't care about the error (not prevent hotplug) we could only 
pr_warn() and continue. Maybe this (unlikely) case is not a good reason 
to stop memory from getting onlined. OTOH, it will barely ever trigger 
in practice ...

-- 
Cheers,

David / dhildenb

