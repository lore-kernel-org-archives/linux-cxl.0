Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF64C125A0
	for <linux-cxl@vger.kernel.org>; Sat,  7 Feb 2026 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770481091; cv=none; b=aDVAqXNp7edVbvRuRQrOiziOSa1l5emPbzDM0r1LBbtAJJg3fXx76j3/dCCzTsoGfedVIV73GKRgMO9LEc99/UENj2GdevfKEdAB5d99CXqlN8HExMgzkIez2JUWEOd97MZVKz49iJEwW5E8zuyYBVagEbJSbn2vrWT3X9+YD7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770481091; c=relaxed/simple;
	bh=3brC2JW2rL04COO6JIl/tf2e0T5RhhUokK6ms1eV5Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ovzr3Q2cfCdvkolBSOZJktIegqXpDlK1zFWI3u6FCHO0P4ujfh428hGUNmBPCXkWJJtVKhaB23OCMgIgmRV5VgbFFKNlewPb99yIvb8LXne12Bh5Uz1Sfxgl+xhA1Mpe337N3QDBoo4Ogvnn/kAiomNLkwShH0Y5jz1p2VqQK9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=MKRs1GL8; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="MKRs1GL8"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-501469b598fso13131421cf.3
        for <linux-cxl@vger.kernel.org>; Sat, 07 Feb 2026 08:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770481090; x=1771085890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eOaLMQHVXZHY1yGIh1+JUpApTTW+sDPhpoNVySUsBtM=;
        b=MKRs1GL8dO0zx0hU9Ih9Bcu29zndDerioiI0nCZKtNnWxBBw3TIAmPiMPxS7HhR4oZ
         23OlDyeqYQzwLderECK7tBQAKsAETsctej+l1NAU/zCBBqIGRxCbcpDdsweYzjl5OQZ3
         KU1tShP5zrnPatyVUb2KwWZmCkvykkoi1oCNAjcF9Dlzv3i1nI3IrWwkVoZ6RMrwxy/v
         Q22O8+9WsDc9ToLiHDoxYA85Uirb42/j7U0fVZQ2ch+7IFVQrV6QIAl6v0x/f5sg1csT
         TSQxRKbrSP3MqzJa+e5TXt8eEh9gRtfPFT3JaDqcCeYR1hFsLzKa67CUIq+umAz9emfx
         DcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770481090; x=1771085890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOaLMQHVXZHY1yGIh1+JUpApTTW+sDPhpoNVySUsBtM=;
        b=Qy3CPjWKyr7OULld9fV2gaHL9Sw9PMAxgCCkVOf3WTCTgZEWa7RcZyNHbGO+GEEkhp
         Im28vVkyUEBxu1BTzj88050ZZA+3TNEw7t/xsKiHqPMhHRZzoKWapvTHAKw1yBUtU/yt
         t6I9DHZUriPEthroBcT7MmV5i3NrebL3Ux+c2SrMR9AXeb7frxVUji1kRA9zO6zmfScR
         B1FvIW1dmIj5Cb2zdQ2qa7xmDXYWnwvKB8S2monSaQoPaeN2trMB/ebW/ZYuQjWi297W
         vCbEjLLlXWhJD8wUrj+DkM1ocvIs4+evYeRdicguJNtCY/U5UEWhXadOwk5cCKnDYn09
         X7JA==
X-Gm-Message-State: AOJu0YwEgzpo2I+PiP2noKdb6zNddxHhtpUCF7xfbW5NpRlwT8F5RXCa
	iVg2C5y+z50zlAyY2x4NWeORb1mkEjD7/aUlSUai5rgmRsLBiIS39VUH7XtzFjWq9BbUz+fR6PJ
	b3jB1DJk=
X-Gm-Gg: AZuq6aJhYwWwDdI/MHu8dj7r9WEjogoZVs9RkQyXbp2nh1ZvBXp9FiDrRssgMkzGNxR
	8bl2Twi2RluX01gUI6XATH/idgP9gDYGMRnoX1kqeM/vDNX/U7QUF4jo0ODhV8FtAqccY6J3AiO
	BEi+4FFHKyJ25GWBhj9lFu+091ztS5I6Y7XrWrjcG13W3umF2xHU9pb1ktg4XN7gsG4LPzW4HnS
	zeGenN+J+JdEpQqLByiOhcCE7pAoxdFeLZA2Ma8pNA1qC3XaExwahXBr6Rw1n9GLvsKOq0eDlYm
	e9MQElhdW7BkscmWgipWXiErFRvBklkKRYYmSCtwnNfpi+RbXboFDMurTBPuzU1BpI8/I9MCdoy
	DOIdkl0mgP8xabkcCI+3ZjylEy4jXHzARuNFEzEOCdiJyuvMBVvLkza/LMeq1Hrm9Kao3hLqaXU
	nFDDdPCnKLV46ULk24L2DOiAMphpCPAYzqFd2PItOqF2zdHWoOQn0cGJKN0YyR4EzE8gkaAw==
X-Received: by 2002:a05:622a:1890:b0:502:9b1f:ca3d with SMTP id d75a77b69052e-50639a2cd04mr91314571cf.78.1770481089562;
        Sat, 07 Feb 2026 08:18:09 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506484ca043sm20447501cf.1.2026.02.07.08.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 08:18:09 -0800 (PST)
Date: Sat, 7 Feb 2026 11:18:07 -0500
From: Gregory Price <gourry@gourry.net>
To: Hongjian Fan <hongjian.fan@seagate.com>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: cgroup support for DCD
Message-ID: <aYdlv6Q8h3g2BHrn@gourry-fedora-PF4VCD3F>
References: <CY5PR20MB47474A4D5CFA5E7284328F6A9066A@CY5PR20MB4747.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR20MB47474A4D5CFA5E7284328F6A9066A@CY5PR20MB4747.namprd20.prod.outlook.com>

On Fri, Feb 06, 2026 at 06:00:38PM +0000, Hongjian Fan wrote:
> Hello,
> 
> I would like to check if there is existing methods or any plan to support allocating DCD extent through cgroup, which could enable DCD to the user applications without code change. This would also be a good way to use DCD in container environment ( for example docker ) or other software already useing cgroup for resource management. 
> 
> Use cases:
> 
> 1) Expand the memory capacity 
> 	Creates a new cgroup
> 	Add DCD extent(s) as system-ram private node(s) for this cgroup
> 	Bind cgroup memory to dram nodes and DCD private nodes
> 	Set memory capacity limit/tiering/numa balance policy/etc
> 	Start the application as normal / launch container with this cgroup
> 	Release DCD region
> 	Remove cgroup
> 
> 
> 2) Increase system bandwidth
> 	Creates a new cgroup
> 	Add DCD extent(s) as system-ram private node(s) for this cgroup
> 	Bind cgroup memory to dram nodes and DCD private nodes
> 	Set weighted interleave numa bind policy and interleave ratio
> 	Start the application as normal / launch container with this cgroup
> 	Release DCD region
> 	Remove cgroup
> 
> 

What you're describing is using private nodes as non-private system-ram.

Private nodes are intended for enlightened *kernel* services to provide
discrete interfaces to isolated memory, not for userland to build on top
of directly.

You might, for example, provide memfd access to a private node, and
expose the file descriptor to a particular cgroup.

What you're describing is just producing more normal sysram numa nodes
and providing them to isolated cgroups.  This can, almost, already be
done with existing infrastructure.

~Gregory
