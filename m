Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C9E19CD13
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 23:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738970970; cv=none; b=VxFUPppbd1QL5fqfFz9fmPdl/EtVWEoro9SOQBXIvXApQhpQtKMm5wpbUL8qXw80qQ9JLqFRdwl4YGgbxtatA7Uxv122BynfNTrqlHY/1ruz04DWeMPSg06No/npato9X/hNKDKeNFaj96qHDJ8n0zIfTJH9T76c+xePpExrSzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738970970; c=relaxed/simple;
	bh=LfbUpyjGHYX7RFAeqCfeoZO0Lm3old+X04Jmz2KNwmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pcmU1c1TJyu9hlP31W/YtsJg9dQC7IWJpx+imI8iArttL2HiEyd30be88dSSnDRIhp1slC8H8knpBe8J2orVNRLcVAMoFvlLgcgd0uSsvWXd8IC2dCT8+ip5wWxy8ouDsBJXMyDtfbmiA5iWgoZCZqUor1OhUBZagxmkGpdu/Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LURJPCuy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LURJPCuy"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso15611985e9.1
        for <linux-cxl@vger.kernel.org>; Fri, 07 Feb 2025 15:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738970966; x=1739575766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxrq3y0zWcusMdm5gKmy0RSUVEtUhaV6df4ledtnR3g=;
        b=LURJPCuyQgUJiHM0ekNEUJhwT9HGdVn/BUc86TurajLss3++4qObzPhdi9LtvDTAP3
         /wOsmYOYVGbfzkm16YzzBm189BGGCJDAq3O08LesEsoNjPAClHMSdwSdWiSVAl7j1oxD
         CNehSCZ80Xgpcm6wYuGExmnKY7ycOGYDWYf+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738970966; x=1739575766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxrq3y0zWcusMdm5gKmy0RSUVEtUhaV6df4ledtnR3g=;
        b=NkZdK06wGRPBJpsRLXDF4tWfaCRgAe9JDjQgDGpXAZP9FDxBiu/lYok4pFJZFFXR0K
         8R/f6aq5LRWj9gPisZieUD/S2cbKvaM1sArusWRf7zjnN9rztdBomTSPw/gIka66YKXt
         jiOzp6MUhmB0OIf9trH9K1aGha9rUjHlF+s0lKIQIv7HKdtD4Rb0vDMCdNFZ2iOee5+M
         yR7JB8Ug5QhBVaDLeEwuJP68MpnXVkvcScok1DzR8btgrMcJMLwhmyy8vl/8fcxsjTv1
         AtBjWiRAQkwO/0UAo8tMOfp3rCzSuB/mfqXtcLxUeslZsNVyCs7pyqgoexMRcZB72xYT
         5Zxw==
X-Forwarded-Encrypted: i=1; AJvYcCV3ErpxyQEtjWH8BQ8rUmU/LEwRvTIG2FS0LRK9g8M1+P8we9etiRtkcUPHmVQAUBvd4Lbo0jGKRJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQleBqKJtyipqt06pp820G4/RhcV2u1txEhIvj3UlJZZkYp2yo
	qurGE263IWjMi11G+rUtRynhCec0jXalEERp02CUWg1nlzgVdcojrA4Y5/qa7CUADepdnnsZWv7
	N5lWkR2C6dSEjilCDF7ny70xca+wCAidGYXgr
X-Gm-Gg: ASbGncuYtsP1C6FTVJpJEHoiaRRqVQ2/Qn/AW8is7AjcWx/eCvInCuU7TSh4XIuCYZC
	qnEyRvPXp27Niwrjf8NGcqV8g1iRmrF7VFFuMnLXjogC0v10JNCxC/6FwlAPVTBaF8irBco7O
X-Google-Smtp-Source: AGHT+IHzbgTJPlwhp2rxVyfXTFAiBs82aNuiqx6uZAtVL2iql18//vPZ4iyLFNt7DsusmD2ZyYpKKa2AXyZ4gTFATlw=
X-Received: by 2002:a05:600c:a47:b0:436:e3ea:64dd with SMTP id
 5b1f17b1804b1-43912d3ef4bmr72734975e9.11.1738970966099; Fri, 07 Feb 2025
 15:29:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com> <10-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <20250206164449.52b2dfef@kernel.org> <CACDg6nU_Dkte_GASNRpkvSSCihpg52FBqNr0KR3ud1YRvrRs3w@mail.gmail.com>
 <20250207073648.1f0bad47@kernel.org>
In-Reply-To: <20250207073648.1f0bad47@kernel.org>
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Date: Fri, 7 Feb 2025 18:29:15 -0500
X-Gm-Features: AWEUYZlrtI146fT0ZIPrxYebKfGyT2dPVkxZPcjyu29IMriUNecpOQzGJhSSMY8
Message-ID: <CACDg6nWU7XXn4X3LGy=jxREYDDVaqy1Pq19kt93wQPn_US9iiQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] bnxt: Create an auxiliary device for fwctl_bnxt
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Aron Silverton <aron.silverton@oracle.com>, 
	Dan Williams <dan.j.williams@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, 
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>, 
	Andy Gospodarek <gospo@broadcom.com>, Christoph Hellwig <hch@infradead.org>, 
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Leonid Bloch <lbloch@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	"Nelson, Shannon" <shannon.nelson@amd.com>, Michael Chan <michael.chan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 10:36=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 6 Feb 2025 22:17:58 -0500 Andy Gospodarek wrote:
> > On Thu, Feb 6, 2025 at 7:44=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > > On Thu,  6 Feb 2025 20:13:32 -0400 Jason Gunthorpe wrote:
> > > > From: Andy Gospodarek <gospo@broadcom.com>
> > > >
> > > > Signed-off-by: Andy Gospodarek <gospo@broadcom.com>
> > > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > >
> > > This is only needed for RDMA, why can't you make this part of bnxt_re=
 ?
> >
> > This is not just needed for RDMA, so having the aux device for fwctl
> > as part of the base driver is preferred.
>
> Please elaborate. As you well know I have experience using Broadcom
> devices in large TCP/IP networks, without the need for proprietary
> tooling.

I totally get that.  As a user it is not satisfying to have to
download and attempt to compile complicated proprietary tools to use
hardware features that seem like they should just work.  I don't think
fwctl should be used as a crutch to avoid doing the work that is
needed to get support upstream.

> Now, I understand that it may be expedient for Broadcom and nVidia
> to skip the upstream process and ship "features" to customers using
> DOCA and whatever you call your tooling. But let's be honest that
> this is the motivation here. Unified support for proprietary tooling
> across subsystems and product lines for a given vendor. This way
> migrating from in-tree networking to proprietary IPU/DPU networking
> is easier, while migrating to another vendor would require full tooling
> replacement.
>
> I have nothing against RDMA and CXL subsystems adding whatever APIs
> they want. But I don't understand why you think it's okay to force
> this on normal networking, which does not need it.
>
> nVidia is already refusing to add basic minoring features to their
> upstream driver, and keeps asking its customers to migrate to libdoca.
> So the concern that merging this will negatively impact standard
> tooling is no longer theoretical.
>
> Anyway, rant over. Give us some technical details.

The primary use-case that I find valuable is the ability to perform
debug of different parts of a hardware pipeline when devices are
already in the field.  This could be the standard ethernet pipeline,
RoCE, crypto, etc.

We do have the ability to gather all the information we need via tools
like ethtool and devlink, but there are cases where running a tool in
real-time can help us know what is happening in a system on a per
packet basis.  We actually did something like this this week.

When I look at fwctl, I don't see it as something that is valuable
only today -- I see it as something that is valuable 2 years from now.
When someone is still running v6.17 and we have discovered that a
debug counter/infra that was added in v7.0, but they cannot use it
without installing a new kernel or an OOB driver we don't have an
option to easily help narrow down the problem.

If a fairly simple tool can help perform RPC to FW to glean some of
this hardware information we save days of back and forth debugging
with special drivers to try and help narrow down the issue.
