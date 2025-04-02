Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487B1236458
	for <linux-cxl@vger.kernel.org>; Wed,  2 Apr 2025 14:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743603522; cv=none; b=VZL8yW2T33sfB7D3xhhh6MFRxn4g4vG6/lefUmNSoeW38Ie0BeWUK6JKwDN5UQmx6jibQ53P2xXjP6kVFRPMGcSSzLGRqnkqgMh9VBRQVmp4wkx4reaPpeGT9p5hGvfrJp9jzr70Mhot/nACTkkDd9T83l0tbL4MUX0EpM4BRII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743603522; c=relaxed/simple;
	bh=SVse8nLg1k64iqJlreSoM8jE2NNKWRf+8WCh6pZMTAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFTAbcNjpY8QIQ3giIMnJgXW4nrBLG+82OynTRxs6gK5yFEOBF9BPmqrDc6zpDR9K3zvHcVnE3ByR2h1+/r2/HxNzbOdIh27msWsWjlKwkeIaUGPUuBpIWq4yfB6FqfL9wWp8dBPc1bq57xhjoEnT5eY48oIteJb/MLIsOyzOHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Guy1lzh7; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Guy1lzh7"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e41e18137bso52809346d6.1
        for <linux-cxl@vger.kernel.org>; Wed, 02 Apr 2025 07:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1743603520; x=1744208320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ccje2Q6QXF1byar7KCxtZebQOr9wampoK+PfuNMS7dI=;
        b=Guy1lzh7sz6janTj62G6bz2CQA6FjhQToGLoqHfpKujawGhyOwhRGDTbjr/aiusbIg
         mQLuHXp/TadZ6LP0f4I+gg8c3t45MQNHfEm6IkNWJ/KgFRuZuxaZm6FEacQfSs7ok9SL
         i8KtAeSz0mwbsucgcN4KqBaBYcc4zlgvMxLJjMS80+xqBejHa6x4ppEV8G1jYg7sUNPU
         9CK6I4+vV52FwLnYDtqy8rIYO/wg/g84UVZwO/JMRbtstZJn6MVuZuEUfcI2xT2UffxT
         BlLtEyMF6srKZEi2ZFIAUpiV0eZXdc/jq/9K1Pf+nwo4AflSENZlqBPCu6gfTeXoCdvb
         KUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743603520; x=1744208320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ccje2Q6QXF1byar7KCxtZebQOr9wampoK+PfuNMS7dI=;
        b=U+Pu0i3OlRWJVepxhBOZqV2yvB7aijFm743+TbGg/kcQYa1tkbBUY/22i8OXA6I/TU
         yy2G3JL7c1fmIET0A7IfxKb+Uavsjd8eT9WN+HBKUqZKq9mCKQbtd5pjTQCDNCosvIJd
         iY1jwtbpGkpJuJ1T756pCEWFOK5qttf9A+Ee3YnxnW5TCr8T6JPBJO2FDegZgi7biI4G
         5G8Anh/q/ojxcIViso0bIFrSG5sNlarhjzjX4d5mK1zhHWVOIPYPr3tmeQ4joFXmU2I6
         MdR7GB4d6C5r6yT/dzWHS2CEJtSCG9/7BXtlPvpMHBQz+/Iu70fZ/qjvFLGe5MNqVdG2
         B0Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUINdl8ZdQxOP4NcWgLn7v/TpABkXxCYNW2R4Pf0CGloHLXk0gyIZ9LD23zwpSCapiA2xbIpQ8+2GQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmdmx06IkfiZxbtszFVXgl3CPx/L+7z4ehapXpj77Ay7nv7QdT
	i2V0/f9aU/b90b/kWxa6Udwj4SI2h4Om+6uQMoN2l5DuoYnnlavI4QzpDzQrvjlYYeXAwZjpC+e
	C
X-Gm-Gg: ASbGnctq6piOZozdOfak6UVdPETof3ww5Zt1lxmIc9ncenCH2njy0pQjWsbf9yFA1uv
	FYYk6RbgZBtuAwAB/90cWyixknLoKkRlMIQf+PRg5nzgFx6WiW3+8FwmKI6lokEX/+zV368yBDH
	3NZcGBuV49W+2iYDmyenhmx45sMtHfvYvB7vbKyEN2J+EQmf9rZIN1m1/82ZQQouT0pKVvqNMen
	uKq/MkZd+LQBlqN3ExcktB9wA7Erkx+TEoXoZjBFc1m5Fj66AGzuGXHhKjCe1PBsikg99QptxC4
	7gqqJwPPu5aCkWB5V++4u4V/HhOzipyDfjcuaMHVRaEpuKy/aRUzX4zeHnkEbyMJ6VllP2YWL9B
	kxQUSa3W05lNYtgYV0aRI58d1aTU=
X-Google-Smtp-Source: AGHT+IEc72cMstQuXqnedf70W46ont8VDgoRyCW+a/CSp5jMBokRXM6GrglR5RZE02gJalJhlKcaJg==
X-Received: by 2002:ad4:5f07:0:b0:6d8:a8e1:b57b with SMTP id 6a1803df08f44-6ef02d3a6c7mr53648286d6.36.1743603520198;
        Wed, 02 Apr 2025 07:18:40 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eec9797b3asm74517846d6.100.2025.04.02.07.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 07:18:39 -0700 (PDT)
Date: Wed, 2 Apr 2025 10:18:38 -0400
From: Gregory Price <gourry@gourry.net>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: CXL Boot to Bash - Section 2a (Drivers): CXL Decoder Programming
Message-ID: <Z-1HPqufU7MnQ6ii@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z6OMcLt3SrsZjgvw@gourry-fedora-PF4VCD3F>
 <Z8o2HfVd0P_tMhV2@gourry-fedora-PF4VCD3F>
 <cf7b97d8-4393-424c-89fc-aa810d907a67@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf7b97d8-4393-424c-89fc-aa810d907a67@fujitsu.com>

On Wed, Apr 02, 2025 at 06:45:33AM +0000, Zhijian Li (Fujitsu) wrote:
> Hi Gregory,
> 
> 
> On 07/03/2025 07:56, Gregory Price wrote:
> > What if instead, we had two 256MB endpoints on the same host bridge?
> > 
> > ```
> > CEDT
> >             Subtable Type : 01 [CXL Fixed Memory Window Structure]
> >                  Reserved : 00
> >                    Length : 002C
> >                  Reserved : 00000000
> >       Window base address : 0000000100000000   <- Memory Region
> >               Window size : 0000000020000000   <- 512MB
> > Interleave Members (2^n) : 00                 <- Not interleaved
> > 
> > Memory Map:
> >    [mem 0x0000000100000000-0x0000000120000000] usable  <- SPA
> > 
> > Decoders
> >                              decoder0.0
> >                    range=[0x100000000, 0x120000000]
> >                                  |
> >                              decoder1.0
> >                    range=[0x100000000, 0x120000000]
> >                    /                              \
> >              decoded2.0                        decoder3.0
> >    range=[0x100000000, 0x110000000]   range=[0x110000000, 0x120000000]
> > ```
> 
> It reminds me that during construct_region(), it requires decoder range in the
> switch/host-bridge is exact same with the endpoint decoder. see
> match_switch_decoder_by_range()
> 
> If so, does following decoders make sense?
> 
> 
>   Decoders
>                                decoder0.0
>                      range=[0x100000000, 0x120000000]
>                                    |
>                       +------------+-----------+
>                      /                          \
>                     |      Host-bridge contains  |
>               decoder1.0     2 decoders       decoder1.1
>       range=[0x100000000, 0x110000000]     range=[0x110000000, 0x120000000]
>                      /                              \
>                decoded2.0                        decoder3.0
>      range=[0x100000000, 0x110000000]   range=[0x110000000, 0x120000000]
>

You are correct, i'll update this.
