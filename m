Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0BE156676
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jan 2025 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737733858; cv=none; b=cpVsDjiBaMozyOyLvEPOCM/0wuiPSlfsN6/2m46H+frXWyKn0F8zi3yLEMqhcKMYBxk4rcZiHZcWxk7sG9DQqMcp4BVsybAx96DFU/s7hZounmUgf8BvcxIZ0uTu0f9O2cIRqVods5kj2j0YdoJLPaiCCA47WtEQaG9fssXPXlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737733858; c=relaxed/simple;
	bh=Xd88S9rJFDlyTkiDBd/JZRM3DywNEkSERz7rsRK8CSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkIycBbuYc47tvGKEc6U71N2jft9FRy/YY+6FUEcnBhD3sBEpqsgY7zji2DzaEw8lfrlhlmUOinuafvrmnRtEBad8Z03bWPlEk+0j88/z0sxraXTV9sQhV2BbNnHakcINRceMMq4witl0UZmMLoEJsriToKfYnJ+dqP7ugtqT+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=G7Qi5doB; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="G7Qi5doB"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b6f19a6c04so198243685a.0
        for <linux-cxl@vger.kernel.org>; Fri, 24 Jan 2025 07:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1737733856; x=1738338656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=61trCC9x4jM90qFfnW/HSs7SoO12eYgtCwi7Oo5kifs=;
        b=G7Qi5doByO3hyute6yUWkEsL5hhgzsQ9WFjrPgsnZ7B6MVgSsHw9fnWU7BluVkHEzG
         nJ8pySrjNoKKzmZBoaCMMj2/pzyBLfsWTcjzAdA/WZCaThIOf8aEk1ScfRpRX+UQtlm9
         OSjSAGvPTmXm8R9UzS4Wa/3eVGDHKD2YNkcThCdj27aZanQCiVSkXRcqPFtsjPhJclRk
         AMNXVRB5+9TrAihok3jrdh8Co2S5Zf4uNoO4ghmXskTb2TF8qmk8Hji8du1syja2+WFN
         EY2n0skokgueX81r3woDyWhWhw4HCFIH954MzwcKS6G4f8DCpJFnl+PygXqS8rgtzTd+
         IPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737733856; x=1738338656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61trCC9x4jM90qFfnW/HSs7SoO12eYgtCwi7Oo5kifs=;
        b=H+s5oUvy7zKBRZFSD3P96nIAEVqzhsKzR8PjgN3r6TuLOKgrYKfvLtRWhZmlf3Uemv
         VxDjw+ZwzpQUw23RGrbWFf4ERyzI5Ar0MdlRvRXfOsKsl2OgbQMK+jC3/LvK1KHhO0wq
         k7gZUtYeqhJoEFB3e7u4O+LLV54P3WCsF9vuejJoDd6yuOyaNZjZLzHfvBetY708j3Cl
         wFiAsI1ui1cjXLeFlD0QZwYJ0LfTCg1/AcrGnfMTdvHQRoQDeGZfGB0zWQFH7Trf1nJA
         Zj2T940RlIgc5HU8OOkY8+m+WXNyBrO0sk7Rs8LkE9h0G/37XBkIZ287zObHcOn1/P8l
         D3Uw==
X-Gm-Message-State: AOJu0YxyRflfJrH9a+3oT1CgUWMTf4q1DU8+xu7iR4AQAv45F362v73j
	Xx29oIc1uEsm8C2auf4+OwSPjW4kD9RqHJmVpNKm3rO8J/uxpc0Xba6vh3w5YJc=
X-Gm-Gg: ASbGncs64FO+vjIZW9z/jBIEC59+/u+ozgl13L0xSXM8SHRHq5tTgXodvzik5Ad8jq+
	lX8HQQXZCpCJf7KUWrkTyh5/Li+RjSHl9P291GgsFjDyrjKdz7lOA8MZKQoQQTQLzRACF5pnksD
	VN2tVIZnipkuLMQJ9s9l5c4LKkS+AjejhPiSqzPKwCEI0LjttBvGdYmSJRexo7HXHehxJbnMLnG
	Cv+X+edkH7bXD+UDXYDA33lNVC/qGmbiBLR71G23HW4HhEpBD1VOSLYY8FL3sJGW80cpYQCNxQB
	ZTRHv8XLgghSav26fAW+RVer+CFOpNnk4tGF3Hx5EGybbB3ZgmzxJSTnra9Xphw=
X-Google-Smtp-Source: AGHT+IH6B6I+3rbq6Tn6tyUuzkiCv8vlO406YC2L0GZLd6JAwgeHpirp6HSaWJOWXBgWXV0MtT49WA==
X-Received: by 2002:a05:620a:472b:b0:7b7:142d:53b8 with SMTP id af79cd13be357-7be63287a97mr5504696585a.53.1737733855791;
        Fri, 24 Jan 2025 07:50:55 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9ae992e7sm105520785a.61.2025.01.24.07.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 07:50:55 -0800 (PST)
Date: Fri, 24 Jan 2025 10:50:53 -0500
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
	svetly.todorov@memverge.com, nifan.cxl@gmail.com
Subject: Re: [PATCH RFC v3 3/3] mhsld: implement MHSLD device
Message-ID: <Z5O23R434TcP0fMo@gourry-fedora-PF4VCD3F>
References: <20241018161252.8896-1-gourry@gourry.net>
 <20241018161252.8896-4-gourry@gourry.net>
 <20250124141246.000040b0@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124141246.000040b0@huawei.com>

On Fri, Jan 24, 2025 at 02:12:46PM +0000, Jonathan Cameron wrote:
> On Fri, 18 Oct 2024 12:12:52 -0400
> Gregory Price <gourry@gourry.net> wrote:
> 
> > From: Svetly Todorov <svetly.todorov@memverge.com>
> > 
> > Using a shared-memory bytemap, validates that DC adds, releases,
> > and reclamations happen on extents belonging to the appropriate
> > host.
> > 
> I'll carry this on my staging tree for now gitlab.com/jic23/qemu (latest date branch).
> I'll push out a bit later today.
> Few rebase related changes were needed. I've not tested it yet.
> 
> Also I have dropped the previous prototype device Niagara on basis this
> should give people a better platform to work with.
> 

Agreed.  Niagara was a good step to get here.

Let me know how I can help.

~Gregory
