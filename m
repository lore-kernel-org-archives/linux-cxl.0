Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54C51C3F0C
	for <linux-cxl@vger.kernel.org>; Tue,  1 Oct 2024 15:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727796043; cv=none; b=lMJhgw9vX51nY7oopdUqSZ5j65xEFo/r751+ulBoo6P8ta2HyIfBjzLTuwKhKBp14sk7jQOPFsLXvcRvhRDsD4Pxvm/36IgIfBitSuoqHdK4fgwGvOEiHtefPGnsv31OAAkvkNFen0B3N/75mIqRma5OMxZhw4cVurYwgQ0RhBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727796043; c=relaxed/simple;
	bh=ZU+Z/WlZcaTh47xXgjL+D5zyETNn+avD/Kj0arLV7NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfZ4QDVwkO1vTJGCARLKhMae1gxEVDUtnNHgdW43RAsbDMooblEhQBv/XbfG0dtZ2FnUXdsCDFLsFGlFXiN6ajjGlon8gMXPB8ZydVlYsG1Sw4uLP80waA3zwCRTOf2yddGsmMgmT9FZoi3/A/LdVp4qfZVX7Vi/mhHRpGFYtb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=j1xXWvFH; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="j1xXWvFH"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6c548eb3354so46305206d6.2
        for <linux-cxl@vger.kernel.org>; Tue, 01 Oct 2024 08:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1727796041; x=1728400841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=os7ciG24pZLduUL01Uf3DEB98OBQt4RnR5S6qFgUTGk=;
        b=j1xXWvFHdB9HepYC6ePIdZAd2TU2cL1uUGr2LjU3Jc/qZa3GIjsN5vjiHdCiwQax5G
         XzbB07Yc44ubAAIaMtiVQamly1rhZUAinjnqj1/mWKjDwdvhJsdEaSFKquZlZ4s4J5kn
         HTp7CddHuzFILkiWQDcPBKysfoKJv5zXg+VBrcOwwvgHNM+N2tTANtrntG3ESKRD48ZG
         azx/V+sDIOSLa5jYcqaoQJge3B2qEUIYhsy3//dGzDI4jQL5op8cuiQHX5uQmiBfqWI5
         C1yIgYOuxPpmt+bIl0EknVXKdHrOqP8Sb6SxZ/BDRWLQ4qc7gJXzODtCFBZnKzgL0zfa
         Xi+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727796041; x=1728400841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=os7ciG24pZLduUL01Uf3DEB98OBQt4RnR5S6qFgUTGk=;
        b=gWUaIcagXPtuJKISjYt+h803oTcBKuX5O2U8qaHThRUjdYAGq8t8H7V/kfsZEb2rAC
         WH8JqceiQe/I6Eaqc6YQgdWDV0VDTsLZfPYXchIKFKRgu1GyrIZM8YDMOEFxok3hiFNb
         wMAle2pBL/hUq0payKB1M3OIDwaoihDPaoz6bGc2Amf51awnznpHe4niI55L5Fr4v+3B
         oxvjYZcdsOO5G9HlKhC4pDWt7Vo7B8z6RBW6banejxdfhjMRs7KG0a+n8MhLjmA6Zf/u
         uftq1UaHpZbXyUZF+q70AWx9VRFpNHV1j4TbRko9pbzPv6o3lkwan2wuRlF869G92Zm2
         rg3g==
X-Gm-Message-State: AOJu0YzPCM3wDmfKdVQWLuB6eggo70klGBGFtuD0UapAiEUUD88Es4ui
	7mkhNoTErfUMM3RJ1qKWy4Zu2K17y5QwTAETf2+PAVm3k8bIm0EuZcbuQ6uM6VE=
X-Google-Smtp-Source: AGHT+IEfkdwBIWEZzpIx/ashe6rDUHbFbG5kJrCq2hePig1GgZbqm2JF4/GnUYx4iA8UiMuXCbaUtQ==
X-Received: by 2002:a05:6214:3207:b0:6c5:7446:4fdf with SMTP id 6a1803df08f44-6cb3b5e283dmr258721556d6.24.1727796040646;
        Tue, 01 Oct 2024 08:20:40 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b66b5a8sm50944436d6.79.2024.10.01.08.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 08:20:39 -0700 (PDT)
Date: Tue, 1 Oct 2024 11:20:11 -0400
From: Gregory Price <gourry@gourry.net>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com, rrichter@amd.com,
	terry.bowman@amd.com
Subject: Re: [PATCH] cxl/core/port: defer probe when memdev fails to find
 correct port
Message-ID: <ZvwTKxTc9yDypmkG@PC2K9PVX.TheFacebook.com>
References: <20240913183234.17302-1-gourry@gourry.net>
 <66e511eff0c0d_ae212945a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ZurAiwt7t2WWVrJM@PC2K9PVX.TheFacebook.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZurAiwt7t2WWVrJM@PC2K9PVX.TheFacebook.com>

On Wed, Sep 18, 2024 at 01:59:07PM +0200, Gregory Price wrote:
> On Fri, Sep 13, 2024 at 09:32:48PM -0700, Dan Williams wrote:
> > Gregory Price wrote:
> > > Depending on device/hierarchy readiness, it can be possible for the
> > > async probe process to attempt to register an endpoint before the
> > > entire port hierarchy is ready.  This currently fails with -ENXIO.
> > > 
> > > Return -EPROBE_DEFER to try again later automatically (which is
> > > what the local comments already say we should do anyway).
> > 
> > I want to make sure this is not papering over some other issue. Can you
> > post the final topology when this works (cxl list -BPET)? My working
> > theory is that you have 2 devices that share an intermediate port.
> > Otherwise, I am having a hard time understanding why the
> > cxl_bus_rescan() in cxl_acpi_probe() does not obviate the explicit
> > EPROBE_DEFER.
> >

just reporting back with a fully functional layout - they do not appear to
share an intermediate port, unless you consider the root a shared port.

I see your concern about this papering over another issue, but it's not
clear what to look for or how to look for it at this point.

For what it's worth - another group observed the same issue with different
hardware and produced the same patch.

    "ports:root0":[
      {
        "port":"port1",
        "host":"pci0000:e0",
        "depth":1,
        "decoders_committed":1,
        "nr_dports":4,
        "dports":[
          {
            "dport":"0000:e0:07.2",
            "alias":"device:16",
            "id":114
          },
          {
            "dport":"0000:e0:01.1",
            "alias":"device:02",
            "id":0
          },
          {
            "dport":"0000:e0:01.3",
            "alias":"device:05",
            "id":2
          },
          {
            "dport":"0000:e0:07.1",
            "alias":"device:0d",
            "id":113
          }
        ],
        "endpoints:port1":[
          {
            "endpoint":"endpoint5",
            "host":"mem0",
            "parent_dport":"0000:e0:01.1",
            "depth":2,
            "decoders_committed":1
          }
        ]
      },
      {
        "port":"port3",
        "host":"pci0000:c0",
        "depth":1,
        "decoders_committed":2,
        "nr_dports":1,
        "dports":[
          {
            "dport":"0000:c0:01.1",
            "alias":"device:c3",
            "id":0
          }
        ],
        "endpoints:port3":[
          {
            "endpoint":"endpoint6",
            "host":"mem1",
            "parent_dport":"0000:c0:01.1",
            "depth":2,
            "decoders_committed":2
          }
        ]
      },
    ]

> > So, devA is dependendent on devB to create a common port, but devA loses
> > that race after cxl_bus_rescan() has already run. Then EBPROBE_DEFER is
> > the right answer to trigger devA to try again.
