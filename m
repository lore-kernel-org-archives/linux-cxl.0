Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CC02F6591
	for <linux-cxl@vger.kernel.org>; Thu, 29 Jan 2026 00:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769647919; cv=pass; b=N5zgUj+/Px4F5kXuJO+afLtkBqN7nqDPKuRDrORlZP47V1CpK2I1vb3yQarNzcpBeaWu3P07drZwC/g43mMyoT9Pe15yLPG2Ov/xoecLElLQC5LvkMpA96oo4lMSLx9RDHeGixZKWJNX80loEDg5tKadO4bKVyOex1A2Lx2psn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769647919; c=relaxed/simple;
	bh=YiXiiNjarjrfmHhYggiDjEpcjRB9EfnbT31SW+/WXWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ojdQZh8uCCm6XL9+92MZWaiQ5v8JZCJU0fajxWOj31XtD9W63+p8riFs0Ic8WCrPYND9Nw4JIXa2ZJ5bSzvCzItkc39hNDfiU3VSZxSQIXz57G1WzrIpgrR+PFRL1jxRfr0qjqcW+f9AO88vEjuCye6SqPyK+2ZwRL25hPLE1aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxY0Fib1; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxY0Fib1"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50336cffef9so4017771cf.0
        for <linux-cxl@vger.kernel.org>; Wed, 28 Jan 2026 16:51:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769647915; cv=none;
        d=google.com; s=arc-20240605;
        b=CbeRIJYcboiBtIBcBPplQcVXU1PgZkW5cG8T/LFbWJGw0KKXF7d9aUF9smYTNaVObJ
         1Eaq3bF9K2zzwoGdlfvd9kmspMS8Y4VhbIvw6VnMOHnmf2GL+qyNSvfp77Z0C0PpcTeI
         UkdAMZCUNJJL84trp1fu0FMkHMc73vhxbOk7i14bRwTbJBU1Rm3PGODHpCnXSdwNNO+H
         2wY/CStnXo0cQ9Lu+Tfe20sH+TdB8HvgLq+zgB8NS88F/IznjjamrGgePPlQEz694P5J
         VFTp7y2rpxrd4VhGCnXMt+r+ZxI4fNYtZ+zCMgiWwfJu7Ipbmo+f44fn81I1HFemeQuv
         DMTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vFDSppbKY0RKNDPJ7Fa45/VD2FBPDC6HmmQ5Ho65y4Q=;
        fh=tt5Nih63TJXZxoW9/Hrzm3AOc9+DQZMD4+PDOKB4zkE=;
        b=QeVm1Th5jqAFJYCFJ7jFZuKiOMPsk+VQtNpFPVtUfQJvhQoIIckOykZ9ufW9PcsN14
         YGRuahUCzWAE67lWNVJiGuvCpVAw7VqS8VmZrNqwN+B0FlNkbamc7J0VtoGs/zS0WUVF
         WEtasFUK9iIw8t18/fdCI2u/T8GIKDNM6aoT65WBmYaGbThoA1dOEGVlolg5PDTP77Qf
         MOjbKlMtSBhD/SgQQOm8omtRMSUEriyof6WrYdLceqpiBppgeK1nE7SIEa7oDvRCXC2P
         E60TgNepbcpoANcyhsU/q+dn21zx2Ea/pOfWky9jRESL/nnH7hiNmiTYpNQslnu1HjMz
         6qdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769647915; x=1770252715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFDSppbKY0RKNDPJ7Fa45/VD2FBPDC6HmmQ5Ho65y4Q=;
        b=HxY0Fib1BOH2tGDoPbIUlHUpKzse+VQqyP7NLbCOQ+5kOND3ApKMujr8jKGQEFyLSq
         TSELc6hGsgLv9bn7zWEScrMK/HxK9khgvOuEb3HvjCSWqIq/IXNwsVnRubFY0taTsOy6
         axMR7hQcD4016mAeN3o4N9XxnMo46QNly2Ysew3RS3R71OXLpRI3zJAIJUgu7vFdjM/A
         IzWpokMufc49vUaIX3swaJsR6XKGkqnZrARDSUSL24ebdqmnzawKMnD9DecVAdhBO/9t
         N0mKjiptckiQah5VEZDw/gHrNI8g5zfi0pzVeyYcwggC4m3iYwkn/3Y31oY6NLVYJrAs
         FTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769647915; x=1770252715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vFDSppbKY0RKNDPJ7Fa45/VD2FBPDC6HmmQ5Ho65y4Q=;
        b=to0tRnyBXoyetGLIdbroN5cCxHfFM+iYZ20uDFyvERDjKVxVZgHWrOIq+Cg64fUfEL
         MQY006dH9up0byX9VxhpmkjpSMmu/L74Yc7ys59Spf7GZL6EjUxMyxUTzF3dDTOCU4Tf
         z+gwi7bUyw6Us+U0t2qjOruuFMPJYRoWK4jiBSK3Yqrbo7+kA9zagTH+Z2iFhYxk+Xlj
         2MCeEWcs8mlaVW4sBbspCPkDMuWwVW3mQfW4uXSdyYkMfUqhfsSBjaleqdr+o/RNSzzr
         KshKITo9k8hquxLxoL9+qnFR+3041VVTv4d7L3BdA1bEa9A95tv3qWmSPFCcZXNvb9og
         nGtA==
X-Forwarded-Encrypted: i=1; AJvYcCXV4Oe9c/nDMLs9t+AA4Glipr9tkHKzn7wIZVZIQ0oawHgNSvl/aES/0vd9vcVvPRE6A42Q1SUDUa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVQDoN/sFf/5pnPuO6Op7mV96PUQAyfqFSDosOOVk4ca7t18iU
	zYqjlp45DiyBMqrkZVcUaFTOYZeEXR/xixSEQ/z80mW4LdbsKgYMJ31LI3faQvnTtnZ8bqyVHe/
	WKJOkGl+iuQDrjZ8zxU2DwhoByd+cXu0=
X-Gm-Gg: AZuq6aKN0LSfRQVqWSYbcNSEmIDOsXBqBj6kautqC4MWcNkn7HxIk4tTyqY0d0MSR5M
	baN3vGUzPdxgYDVSZ0pNIPNrty13MvymX69YeSJg8HN6YT0s/oChcQ/KAr9wbsvQm4dyWGSLHCb
	r+Sqm1C/IZT3IfgbgtTpS471zXbfHalb9Ea5Kv9yRP8V9anv1sMdZLQJQQQqd/gfK5+FX1M89mz
	SxCEp6SZlfq+f8VZwCiL85JRX3eOFP5IkSJWdtO8kfTFzaieq8+ohY7IZ83qi7qY4XSAbPiZAvH
	QrIvNwGSCneW9wvL6p8bAVtpxwIIm49nCQ==
X-Received: by 2002:a05:622a:14d2:b0:4ff:c884:31ad with SMTP id
 d75a77b69052e-5032fa0583bmr107426571cf.53.1769647915314; Wed, 28 Jan 2026
 16:51:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113081453.8293-1-akinobu.mita@gmail.com> <20260113081453.8293-4-akinobu.mita@gmail.com>
 <aWZLZzo5Hb1aFZ0j@tiehlicka> <CAC5umyib=XmPkTvRT6eAsMx+WDx0NkSP9djh4xkhLJgwk_v8Mw@mail.gmail.com>
 <aWfXHKDzoQBsHxAp@gourry-fedora-PF4VCD3F> <CAC5umyg+wubKoQSfpDQvNh3K5Y7+iOEYn6_BuKFd53kHDVE7aw@mail.gmail.com>
 <CAC5umyjOgZE0Qpa3W3qZ=sSkwkuf_md47jctXgi5UKWuG49o1Q@mail.gmail.com>
 <aXJSlv1_K1uQCN16@gourry-fedora-PF4VCD3F> <CAC5umyhrcb963mA9dUaZswJKq2MF_OVaipNmy=L4J7u6rPjfqA@mail.gmail.com>
 <aXksUiwYGwad5JvC@gourry-fedora-PF4VCD3F>
In-Reply-To: <aXksUiwYGwad5JvC@gourry-fedora-PF4VCD3F>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Thu, 29 Jan 2026 09:51:44 +0900
X-Gm-Features: AZwV_QhRt-bXjIoQ8GFJDcYRtgG-C9XTXkZwe1eqV1SdIxAZqmC1j6C5xZLj-g4
Message-ID: <CAC5umyi6oW9qZZH75Owitojd+wgTGrz6uHsEFXxzo8aWF7FoKA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] mm/vmscan: don't demote if there is not enough
 free memory in the lower memory tier
To: Gregory Price <gourry@gourry.net>
Cc: Michal Hocko <mhocko@suse.com>, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	hannes@cmpxchg.org, david@kernel.org, zhengqi.arch@bytedance.com, 
	shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, surenb@google.com, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	bingjiao@google.com, jonathan.cameron@huawei.com, 
	pratyush.brahma@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=E5=B9=B41=E6=9C=8828=E6=97=A5(=E6=B0=B4) 6:21 Gregory Price <gourry@go=
urry.net>:
>
> On Mon, Jan 26, 2026 at 10:57:11AM +0900, Akinobu Mita wrote:
> > >
> > > Doesn't this suggest what I mentioned earlier?  If you don't demote w=
hen
> > > the target node is full, then you're removing a memory pressure signa=
l
> > > from the lower node and reclaim won't ever clean up the lower node to
> > > make room for future demotions.
> >
> > Thank you for your analysis.
> > Now I finally understand the concerns (though I'll need to learn more
> > to find a solution...)
> >
>
> Apologies - sorry for the multiple threads, i accidentally replied on v3
>
> It's taken me a while to detangle this, but what looks  like what might
> be happening is demote_folios is actually stealing all the potential
> candidates for swap for leaving reclaim with no forward progress and no
> OOM signal.
>
> 1) demotion is already not a reclaim signal, so forgive my prior
>    comments, i missed the masking of ~__GFP_RECLAIM
>
> 2) it appears we spend most of the time building the demotion list, but
>    then just abandon the list without having made progress later when
>    the demotion allocation target fails (w/ __THISNODE you don't get
>    OOM on allocation failure, we just continue)
>
> 3) i don't see hugetlb pages causing the GFP_RECLAIM override bug being
>    an issue in reclaim, because the page->lru is used for something else
>    in hugetlb pages (i.e. we shouldn't see hugetlb pages here)
>
> 4) skipping the entire demotion pass will shunt all this pressure to
>    swap instead (do_demote_pass =3D false -> so we swap instead).
>
>
> The risk here is that the OOM situation is temporary and some amount of
> memory from toptier gets shunting to swap while kswapd on other tiers
> makes progress.  This is effectively LRU inversion.
>
> Why swappiness affects behavior is likely because it changes how
> aggressively your lower-tier gets reclaimed, and therefore reduces the
> upper tier demotion failures until swap is already pressured.
>
> I'm not sure there's a best-option here, we may need additional input to
> determine what the least-worst option is.  Causing LRU inversion when
> all the nodes are pressured but swap is available is not preferable.

Would it be better if can_demote() returned false after checking that
there is no free swap space at all and that there is not enough free space
on the demote target node or its lower nodes?

can_demote()
{
        ...
        /* If demotion node isn't in the cgroup's mems_allowed, fall back *=
/
        if (mem_cgroup_node_allowed(memcg, demotion_nid)) {
                if (get_nr_swap_pages() > 0)
                        return true;
                do {
                        int z;
                        struct zone *zone;
                        struct pglist_data *pgdat =3D NODE_DATA(demotion_ni=
d);

                        for_each_managed_zone_pgdat(zone, pgdat, z,
MAX_NR_ZONES - 1) {
                                if (zone_watermark_ok(zone, 0,
min_wmark_pages(zone),
                                                      ZONE_MOVABLE, 0))
                                        return true;
                        }
                        demotion_nid =3D next_demotion_node(demotion_nid);
                } while (demotion_nid !=3D NUMA_NO_NODE);
        }
        return false;
}
