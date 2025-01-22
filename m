Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FAF14A619
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jan 2025 06:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737525812; cv=none; b=nTYc3pRgQZlyhV9WYyWhwYsdFJwwvsBdaVHmJGuk0jO/bV57LVDUxVwvMS56BGMVuumh/n5Uf64dYeKGAmyOq18OU0yKhVEz0X5Qh1C4gUl8BEkYkDxYxvA/+x3eoyzpGNc30aWK17aHB6mb+cMFOfSbZfLxfVtLYCakLOvvuqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737525812; c=relaxed/simple;
	bh=jUO9TLmOMbzz9oZqJzPfV+MbyKJ9KsX8AxvOLB6ZEk8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btXjsBxxM/+KTkPZy2pcl0ej5OBSgoJ6BUgKS8xGqrJh58N03B2LFkkUXFNHLUZn10JVFfJTYkTFUqYANKbsOFqAA7mTs+ny6tBY5B7G4uhUSMIXgDSQEgHDYpAyUt/u/xhT1iDBGe9eVztHE42QZSnGOo6PAwMj2P7xpjV6AOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pp7AaOJx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pp7AaOJx"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2167141dfa1so9426945ad.1
        for <linux-cxl@vger.kernel.org>; Tue, 21 Jan 2025 22:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737525810; x=1738130610; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dV02xLcbn+l9kZ6Ag191QNsfZW3pqFE6YGpatvGLbAA=;
        b=Pp7AaOJxIC/55gzFHNQUA0PNuTrL/HeESqYAaCSThLeIXxehKnUwP1tYvD0UcNOCY0
         gUvgYvtHN9FHuJ+p/weRiE5qrRdLjcaqNupUvIVUTZIDVMaqI07omzYYcO2UUyGRTzN0
         lJMrQA/xk0Eb6SxMekfDLabechdSctt6casssm7l82OXDvgT+YoWdqD+sPcizEFzCpsw
         ONh8gE5YkIDcRgM/siJv83RspqlI0k8l7hp9vJv/7Oxx8BIVRW4jOq1LTPYmxg5AhqCz
         Z4POH8zh3gluEPmJSe+IrbVb06hxKyF/CeQFg0xsqFSO8rFERXcVsw9Ah0NIMDzqf/Rt
         x+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737525810; x=1738130610;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dV02xLcbn+l9kZ6Ag191QNsfZW3pqFE6YGpatvGLbAA=;
        b=ply2W57CcEEAAB8EmticodrHR9J/pfRvGvy2FeGbynG6d8X914oHz8LeEF854o0/MI
         EiGL6GL7dZfn3Yuth0O6zOM0y1hbn9idHEhEFfA/2Lp4jNXFCfKW3V1Yvb2ZFEJrI3b2
         5ptTaGq4hyI5be6Ig24vq/Dak0YUMK00UuGQ1X3jT3bCMlyiIUGfVEqULYcODqmnuMaL
         thPv3arizLXJJ4fkRMK4rXbH9l9jpYiVCgIyqrAb7DC4RoX/Sj1WoAkI8hnXqjE8JqJc
         KXoONzyhr39NKV1SjEe2dzmuz2k9qrG7mUeCxl3iYOI8ndz65KcO5Ktzn7T6WwpxaFlE
         zEeg==
X-Forwarded-Encrypted: i=1; AJvYcCWpKhMjlmrlWekqUMnaVjWG+D/9w8qQ0KaKYhEAPcfzBOnO2GY5A2zd4ZvSA1vTnvcnmw2REOBnX3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqf89/AOjtotrY5NLQ+A8ulXOHPN8HT6A3vtV/ht2RsbXh1lsm
	u923gdVitlqjbIPuxTI0KGYx/tMqX2tadg1dE5Vew9pLG0BPxJiF
X-Gm-Gg: ASbGnctWjRYIuQlh2qrMgbjH+gRldFGe5RAg91pfkUcz4UE1MJ+ustpWZVfxIcwzIth
	LrMbRCUGS67zY10mACX2aUcIMuM+rFU1Lo5o7K7YICDstBZRgsbgmu+xIWNVi0PeNDoeYYOHORk
	euQUYOmiQGK4OZaSZbi4R9N+hE8rbeT/57Ug606eBQUn8xggGcAMvcqzG7CcZ2chaeaoSdh3j3o
	jrjrqziFviT82jO7nhA/vN8SN4EsHa1yVRlPKilJOY1B6GeCFWIL8DVoE9Y
X-Google-Smtp-Source: AGHT+IF+aYq2LWO27vKKdB7RYk+WDhf+Bt/rICsEvzrS8MaRHQm64phKz2lq9nowEdm8XJRHRWSemQ==
X-Received: by 2002:a17:903:2410:b0:216:2aec:2d54 with SMTP id d9443c01a7336-21bf077dbc9mr433248755ad.8.1737525810405;
        Tue, 21 Jan 2025 22:03:30 -0800 (PST)
Received: from gpd ([2601:646:8f03:9fee:1eca:6066:421d:7396])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2cea0763sm88247105ad.9.2025.01.21.22.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 22:03:29 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 21 Jan 2025 22:03:35 -0800
To: "Fontenot, Nathan" <nafonten@amd.com>
Cc: David Hildenbrand <david@redhat.com>, linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com, alison.schofield@intel.com,
	linux-mm@kvack.org, gourry@gourry.net
Subject: Re: [PATCH v2 1/4] kernel/resource: Introduce managed SOFT RESERVED
 resources
Message-ID: <Z5CKN57paDmGJH9A@gpd>
References: <cover.1737046620.git.nathan.fontenot@amd.com>
 <1800b17449d1c231292c85f59b226aff39a81552.1737046620.git.nathan.fontenot@amd.com>
 <4e556200-c790-4e0a-b103-2a1529c81927@redhat.com>
 <3c7c5b87-f241-482b-9b00-98e2e53d8e9c@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c7c5b87-f241-482b-9b00-98e2e53d8e9c@amd.com>

On Tue, Jan 21, 2025 at 12:57:19PM -0600, Fontenot, Nathan wrote:
> 
> 
> On 1/21/2025 2:19 AM, David Hildenbrand wrote:
> > On 16.01.25 18:42, Nathan Fontenot wrote:
> > 
> > Hi,
> > 
> >> Introduce the ability to manage SOFT RESERVED kernel resources prior to
> >> these resources being  placed in the iomem resource tree. This provides
> >> the ability for drivers to update SOFT RESERVED resources that intersect
> >> with their memory resources.
> >>
> >> During boot, any resources marked as IORES_DESC_SOFT_RESERVED are placed
> >> on the soft reserve resource tree. Once boot completes all resources
> >> are placed on the iomem resource tree. This behavior is gated by a new
> >> kernel option CONFIG_SOFT_RESERVED_MANAGED.
> >>
> > 
> > I'm missing a bit of context here.
> > 
> > Why can't we flag these regions in the existing iomem tree, where they can be fixed up (even after boot?)?
> > 
> > Especially, what about deferred driver loading after boot? Why is that not a concern or why can we reliably handle everything "during boot" ?
> 
> That's a good question and one I should have addressed.
> 
> The goal is to prevent the dax driver from creating dax devices for soft reserve
> resources prior to the soft reserve resources being updated for any intersecting
> cxl regions.

Not an export. Can you explain a little more here?
What is the problem if we only flag the resources as "soft
reserved" in the iomem tree without creating a separate tree, and
process the "soft reserved" resources only when needed? 

Fan
> 
> During boot the dax hmem driver walks the iomem tree to save off a copy of all
> soft reserve resources. The dax driver then later walks this copy to create
> dax devices for the soft reserve regions. This occurs before the cxl drivers
> load, create cxl regions, and update any intersecting soft reserve resources.
> 
> To prevent this the soft reserves are set aside on a separate list during boot
> so that they can be updated (if needed) and later added to the iomem resource tree.
> The dax driver is then notified of any soft reserves added to the iomem tree
> so that it may consume them.
> 
> Hopefully that answers your question. I'll include this in the next version.
> 
> -Nathan
> 
> > 
> >> As part of this update two new interfaces are added for management of
> >> the SOFT RESERVED resources. The release_srmem_region_adjustable()
> >> routine allows for removing pieces of SOFT RESERVED resources. The
> >> the merge_srmem_resources() allows drivers to merge any remaining SOFT
> >> RESERVED resources into the iomem resource tree once updatea are complete.
> >>
> >> Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
> > 
> 
