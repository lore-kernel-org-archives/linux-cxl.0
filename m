Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1DD214A9B
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 18:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740076993; cv=none; b=Ic21MJ3a3UYukN3Q4Blx0SzXWKIdcwNDEOgtQ8xvcZx6wq5dPrNI+u5WWCnfSDC/xe/UQHZeOGsn6UZCETBA8RUxVpRlq12QYyC60NP1CYsC3mPsIrYtnczu66uzS/Zm4MZNP4X2ps/69lqDGG61RBGTqhK6G15L7YvEESzhowo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740076993; c=relaxed/simple;
	bh=NGgRHDDGedIkLCbRWOHyqQOCNZ+JrdBTernCwcw6jCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVxpJHEdWltbnTkjfwSan0jQVLiDtioX/rwqvHpbbKeUJBXq1f5WmEUrnNhR6Yw6A6Ypby6qsAPXhHmvzU5vf6pvKMxKv8Tfi/t5+eCL9z6dwoW7hJUDdwC1YSuUMRZ+G2l5oR6H5AoKnD989vOVjbQ/hRuFgrxHMy0CQ5qXJzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=QDattucv; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="QDattucv"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6dd43aa1558so10669916d6.0
        for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 10:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740076991; x=1740681791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d3ocJQTmmz808+gv+xcTfLZcwjDZn2/TIc1rnG0DoJg=;
        b=QDattucvNS6moBrMSgaG5SsfkFzwVXed8XaI/41d5kZzUN4F7IQNv9DXw/fWu+oTmu
         sKGJAhO0+hDbCay1Bhjhd7tadu5RBj30v8G8Ns58nUBgj5FZP2c+5s3nFW+bBVsEGZ0G
         QRNtLyEqpL29QJVVKs4hz3/DIocUz9Kq7Wkb4h7AXcGR+mu9X5wxEapdPojpmpBO690T
         sZtloEG4y8k//BzeqZ+mvjkuQ4u0rtDE9pMWFv34PwDpKBRNm62qumAx69G2j43u4XwR
         avsfAIKx/EI9jpIs+tU//hlRE+f3PfRUYWUt4NcIJKdk+J1VnV7xeWwxSrmWZyYgPVjf
         +l7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740076991; x=1740681791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3ocJQTmmz808+gv+xcTfLZcwjDZn2/TIc1rnG0DoJg=;
        b=ceytDH+8iTcLyucSfaLdlFCy/ftreb2XnzhUq8vuOuEXvSZWHjXeQ++1mKNmjgXDep
         xWPz4cQ8XoAidI/27kQdSuwKPrAiVDjFDdmzmQZF3nXpId5tIOpFLjPpfHFr2Y29q07Y
         +M5MME5OW93hGEGIW5M1k3zTtq9KtPu+JENHhD1N1diDULpQ36ZeFDin576ueRsTBBiF
         fVup87lvBHTsBBJajUoDItn7hQlqcCqRxSccQ85/FEP47RJm3hQ1lQTf0ybTvR1XJSdb
         1Zsh3UUCd+8S6Qx68GiiNsJEFXz9atiyqm/UdrfT3s/eXtf9xDPMifilwy4Kw8MKwYax
         zhTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPm69nJ0F0ebHrCyYoSfmYZ8B1uhSfSaWOJBp+SCqq7F7xpvz8p1qv0YHNC7gJSylgvJ0yZhm4ebE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCZajrlBXd41tz5o2DxacvFbJD2/KNSOUS9aGXNPDuGOKltEQG
	JsHe1NGijczRXEbBZQyLLVuT/ZZHe5FL7nfm/eYLli+EL0+qPLv3c2zcEAzLaEbZvGFR7qLO8Om
	j
X-Gm-Gg: ASbGncvDogvB0CdDhBsKQnF+Z5Ydygt4TS5Ijv494lW0Zx9SfsQ9lW58qpT98hOXDDA
	VyQG5MYX6MIM8RpUAzGRjxF+QUyyxMipw6zqJmlYVzV7NnjXte/qSYECjUSWlzoxuJ5Knx91ee0
	gMkGAGo+W0vuTJkl9xi85oVDUiavcLqBAWEdS/dZvH6xK939nzYzoAYovN08O+1YgSD4n5YMK0o
	7QqarJBJQQiQDAedBdIuzBMRRxVrfcxWgVkm2XBWvALdRAj9lo5wh9OqlKEVt5rAqbBloP3cyRM
	X7L9UxygKmm9FcCt0FEYbwIUelmQnco8NjRrofpDkXffjltLssEmpCrsmc3ElvcaNhx0eGoS2A=
	=
X-Google-Smtp-Source: AGHT+IE6IpITASnEll2pNxcvCEXqhyJQ61kCnsAXUIqsUkMLSxo6fEasrPnRH6TZnjk08cEAdB+JcA==
X-Received: by 2002:a05:6214:d8a:b0:6e6:64a5:e18d with SMTP id 6a1803df08f44-6e6ae7f8290mr2793666d6.17.1740076991097;
        Thu, 20 Feb 2025 10:43:11 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d77a2bdsm88435726d6.11.2025.02.20.10.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 10:43:10 -0800 (PST)
Date: Thu, 20 Feb 2025 13:43:09 -0500
From: Gregory Price <gourry@gourry.net>
To: Yang Shi <shy828301@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, lsf-pc@lists.linux-foundation.org,
	linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: CXL Boot to Bash - Section 3: Memory (block) Hotplug
Message-ID: <Z7d3vVdJ8UWU5oex@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z7OWmDXEYhT0BB0X@gourry-fedora-PF4VCD3F>
 <CAHbLzkq6Me6nRaL6b09YxJ_nFkxb+n+M3-q_aJwOs2ZO4q8VCg@mail.gmail.com>
 <Z7TLwtQY3vGUw2bO@gourry-fedora-PF4VCD3F>
 <1b4c6442-a2b0-4290-8b89-c7b82a66d358@redhat.com>
 <Z7TswQbpPV590ADr@gourry-fedora-PF4VCD3F>
 <bda4cf52-d81a-4935-b45a-09e9439e33b6@redhat.com>
 <CAHbLzkqDQcrHLPzk8n0SMgkidH2ByCqdwfYXX=uBPQfOArWf8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkqDQcrHLPzk8n0SMgkidH2ByCqdwfYXX=uBPQfOArWf8A@mail.gmail.com>

On Thu, Feb 20, 2025 at 09:50:07AM -0800, Yang Shi wrote:
> > > I will double check that this isn't working as expected, and i'll double
> > > check for a build option as well.
> > >
> > > stupid question - it sorta seems like you'd want this as the default
> > > setting for driver-managed hotplug memory blocks, but I suppose for
> > > very small blocks there's problems (as described in the docs).
> >
> > The issue is that it is per-memblock. So you'll never have 1 GiB ranges
> > of consecutive usable memory (e.g., 1 GiB hugetlb page).
> 
> Regardless of ZONE_MOVABLE or ZONE_NORMAL, right?
> 
> Thanks,
> Yang

From my testing, yes.

~Gregory
