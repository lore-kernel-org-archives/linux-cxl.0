Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238A3269CE6
	for <linux-cxl@vger.kernel.org>; Thu, 13 Mar 2025 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883004; cv=none; b=InbvQsHMivxrMXG0nNwzm8cfS/ECqkjomsMD/hKB0B+cZ2xI2t5eylcRIBBi9MgkvJIzaUlwaNPyYojEmYzWSkUdxfKzUiLIDSWyz/2ai89czRIBEQq4Vfp4ce42isal1Q8ckN5vSzhjAeSg853RxpA2A9T2+OOJ0Dws1bEAKKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883004; c=relaxed/simple;
	bh=l5Bu+TyRNUWlmGj5EcMKN9XpyeX6l5pAcSIM2YB0SJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPTYJ2gMBWQ8d+EeGy3eRvCMK2Tzz3tjrs+M7OOM4fbqcdDyhH6og2CBhRAoOj/xG/NdOlUi84tzxVOUyPo20AXXjWbtWtBe2tniqGsR60tk9E1b7MX5q7P84RzpqAmAnNWpKOzEyeecI73bsFNB1CAXAgnabsqeYsQOoQa8PKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=XRifKj/6; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="XRifKj/6"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c089b2e239so129259685a.0
        for <linux-cxl@vger.kernel.org>; Thu, 13 Mar 2025 09:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741883002; x=1742487802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KrRFUJhkeyaL1R2Vv0+vn3p6ZJnpUo2ZC2Z7tEGAZfw=;
        b=XRifKj/6NoYLbHvC701UzsyhxZSTvFSeO1lVMk2NpESGpCaKV3EcC5mGeTClMgHQn7
         PMt9mxPlKbQbLeqKw8Q6jvOWMh55gQefjLdK6QnDBNs/VnycTJ2wOUGN0xMdc7mxjxUi
         0x1wuRlzmokhZLE/1Pw1OmvRWbS0puaPU8olfH43w++S/lskaGGgABJ7d0RAS2gyCuHO
         GQaA52KaaZ4aotNe4h0DzslNBL2CGLX78irH3KRoxjpTGcRL3XdfzIeKicAEiizdDkx2
         37okxbG36tf9yWxqc5DMJeepcBDvOVl513iB2X7T58XC85+ygDLMk0diu8GhvZwtYsWW
         1ZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741883002; x=1742487802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrRFUJhkeyaL1R2Vv0+vn3p6ZJnpUo2ZC2Z7tEGAZfw=;
        b=Ed/wFnack+iFQbkuxO4iUT6LyHh7k+Ow2BKd1r1GoAoxzpXTFjiiaXPDs/vlJka4SV
         j6WVtCCyA6zdcEdv3tlxgpGcGNMRq0J5NGtVwdXyOc2IOQIAZhBvtLcy1iF9kOZEfoP8
         KjdiqrOSRzJGTTr5f7rpJOJmsbkbqsx3RmlusrRFNyU3WRRH8fN2f+DCDqmCFfqmzMGs
         J7UK4okRM1SSWBuliUzv1P3Wxj/HORvs87+/2wCa7NgCY7+/Xy+Z97HsY2TQiT7Vf/Yf
         ADuid4arF6xgEA7A8qBQy9ZkuryxUiM7T3cMBodm9JRNvtwH4szOPSjvPWHrWELzOr6o
         dKlg==
X-Forwarded-Encrypted: i=1; AJvYcCXwTnX05ix0OFVmxCpkB5OuFzeTvNB+V7cGL8ZOeWaFq20swxXzhCbPtysIt1pvzXOdCxLbtg0ludg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm3Mb1nz8SbtH6CvelpLiJhNTfRnnoVQaM4M2CQRF65RR/5sYQ
	dLoDgsTXAzK85zIdBXHHhjxlaPr6NcJpo07Q1D36pBpw8IzO2lpH9+CKXTqFZ0o=
X-Gm-Gg: ASbGnctO3oAfl+cqUwgAdO2Ls/tm48H6I/QxWUg8BNttYuTn5MOmsRP7w0UJcjFND1j
	PV5viPlK86QqjXedOQxbh79o6Fi4Gbsi4sxEf301OgZHRYAeDu4ru1Jvp1RVd16/w7q7TZ1YQCm
	lc/ZuCEpY3CgYMePYRDEacMLvkEyK141965d5g0EQCiUrQw3visoEb56aiVI22gdheQj34rBlzZ
	AoDPCjvE73n1Jp+LsRD/CfPaTtZH7LQmc8sMzzvJF43hL0eLG/SWs46T+x4z/Mf7b6Bt/ommQJn
	HCQwwuC8l+N49SLe1MKvhz/PT0GGR3xMByp5KzVXO7ffggqqgCckLuSxSA2Oqkc6+fC8mFhOaTB
	RhWtcTc+rla9oXtaNDemH5gB2Xms=
X-Google-Smtp-Source: AGHT+IFmSrDkHOW9CD4C+SfuWoYsDhx22Nfs217sGKgO8g7l8OBfmKzMb0gcROREHfpiz274St3PtA==
X-Received: by 2002:a05:620a:8323:b0:7c5:3da4:5bcb with SMTP id af79cd13be357-7c57376cde3mr447561585a.10.1741883001932;
        Thu, 13 Mar 2025 09:23:21 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573da455dsm114957785a.115.2025.03.13.09.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:23:21 -0700 (PDT)
Date: Thu, 13 Mar 2025 12:23:19 -0400
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, kernel_team@skhynix.com,
	honggyu.kim@sk.com, yunjeong.mun@sk.com, david@redhat.com
Subject: Re: [PATCH v2 2/4] mm/mempolicy: Support memory hotplug in weighted
 interleave
Message-ID: <Z9MGdwrgX8dYeHha@gourry-fedora-PF4VCD3F>
References: <Z9GwNWNC9VfR3Y6A@gourry-fedora-PF4VCD3F>
 <20250313063351.692-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313063351.692-1-rakie.kim@sk.com>

On Thu, Mar 13, 2025 at 03:33:37PM +0900, Rakie Kim wrote:
> > I'm fairly certain this logic is wrong.  If I add two memory blocks and
> > then remove one, would this logic not remove the sysfs entries despite
> > there being a block remaining?
> 
> Regarding the assumption about node configuration:
> Are you assuming that a node has two memory blocks and that
> MEM_OFFLINE is triggered when one of them is offlined? If so, then
> you are correct that this logic would need modification.
> 
> I performed a simple test by offlining a single memory block:
> # echo 0 > /sys/devices/system/node/node2/memory100/online
> 
> In this case, MEM_OFFLINE was not triggered. However, I need to
> conduct further analysis to confirm this behavior under different
> conditions. I will review this in more detail and share my
> findings, including the test methodology and results.
>

+David - might have a quick answer to this.  I would have expected a
single memory block going offline to cause a notification.


I think the logic we care about is here:

static void node_states_check_changes_online(unsigned long nr_pages,
        struct zone *zone, struct memory_notify *arg)
{
        int nid = zone_to_nid(zone);

        arg->status_change_nid = NUMA_NO_NODE;
        arg->status_change_nid_normal = NUMA_NO_NODE;

        if (!node_state(nid, N_MEMORY))
                arg->status_change_nid = nid;
        if (zone_idx(zone) <= ZONE_NORMAL && !node_state(nid, N_NORMAL_MEMORY))
                arg->status_change_nid_normal = nid;
}

static void node_states_set_node(int node, struct memory_notify *arg)
{
        if (arg->status_change_nid_normal >= 0)
                node_set_state(node, N_NORMAL_MEMORY);

        if (arg->status_change_nid >= 0)
                node_set_state(node, N_MEMORY);
}

int online_pages(unsigned long pfn, unsigned long nr_pages,
                       struct zone *zone, struct memory_group *group)
{
	...
        node_states_check_changes_online(nr_pages, zone, &arg);
	...
        node_states_set_node(nid, &arg);
	...
        memory_notify(MEM_ONLINE, &arg);
}

In the callback i think you want to check whether N_MEMORY is set

+	case MEM_OFFLINE:
++              if (node is !N_MEMORY)
++			sysfs_wi_node_release(node_attrs[nid], wi_kobj);
+		break;
+	}

Similar with online (don't want to double-add).


also from what I can tell, N_MEMORY implies N_ONLINE because N_ONLINE
occurs when memory blocks are added (regardless of state).

~Gregory 
