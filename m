Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4891F229B2A
	for <linux-cxl@vger.kernel.org>; Mon, 12 May 2025 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747060276; cv=none; b=a8rnFssFnzpOibc8xea+xEq+NU/lIW/Pd0y5CTv5sCE88dihyvDfWSen75omZC1KX8GtlIzycsvY7lu4KRNjuYTnlOX2ps+fH/e+atftQCtCZLQK4wtMLiCfcY5CIoLhIvyKYcwGxuvOqWOdYQ6fdjoyq8MupIkqa/nMsCMInyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747060276; c=relaxed/simple;
	bh=EOi9sCZK85Y4bJopmUCYi3swoe08DUuLECCP1N+fSw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHLIJO/ivWeCbyMX21qY56Y6pmM7FI4xdpqhG0p9fXr+b7caXkxB1Yk7Y39YE76tM9APy/KMIDdld9H1cukvHWjTk7d3BrA+M8f6ONASOxF5v7JeAS2OT2xPOntj355Mi5PPTWUHO7hKVTIrCwLhqYu2BFjn1gaE2hp8/BLk2Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=P54ffw7N; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="P54ffw7N"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7cadc92771dso480925385a.1
        for <linux-cxl@vger.kernel.org>; Mon, 12 May 2025 07:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1747060273; x=1747665073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jCXKXHReqot1wkAPOvwV0YSnLbprI4u4HniI9fLKEYk=;
        b=P54ffw7NmT42zxMyhR4pOjV1DG7nqn43w9myW1CVDiccO7nlpShjQDHuMqRoQ2bFrx
         Yn7a0/GBkbPPAhKykXE5jD9wYZPNl5E8871N19ws+/8DQiyvJpyAOoeZBDTx+kpgSNDw
         KuJ2BlT+6TObuME0aSEvU8Yqm7SIzjtQQ93W1U+nX9B3HVRoUR256E0sU+4VOtBRH8dd
         F9MUDcOqzMGwWxQwfx2GmOvsPKCzd3FyXjZw3cPn563VYMRWya5NignqQRURZFdvyhSp
         ApNx7NVVyxSsWbosxkHdRhVH8qEPO0rFf+ThngqR3UacjCEmLRGkpw8jD7qnU46XXGxE
         3S5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747060273; x=1747665073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCXKXHReqot1wkAPOvwV0YSnLbprI4u4HniI9fLKEYk=;
        b=D9Zu1xNQvUtvfUPutWR1B8nXHkbmF1h+/9CWSm+BYp7WIoBtQw6yM676KJdCKze/j5
         yhq/I0Fu/9IILzM6bzMzIba1Cd/4rPuvlZ620ubW2Bq6QYfD/UOFDkXrpN4YHBkDiabK
         lpsqxi+auhCCZN4zlT3DLVmLHVl3cXO92Pnf8R8dy1jmLdplAMdZT4lz4ydMz6Qp8ncO
         qAq2iGJnCRjN1oYWXWaQ2XhW9JcFS0qqLEN1zzuHOJrz4XjeQDFZ3znkbfUUt0F+Zlq+
         l1jkkZ2E02Z48Rr0jzgUhTYiNbGSrGRpmNRHiPsCvTRKKvsXun9QuRvjSyvstkqyLYI8
         mLiA==
X-Gm-Message-State: AOJu0YwTXHTcby7zhCi7LL+ySoDTvYILTDw0k7K9SkNemL46dYNR76PN
	aKlQxvEBf27XrixFC38bbEj3ipZhjpnsYhN8FZEaaiDcJr5+IH8508BiGYhAEPY=
X-Gm-Gg: ASbGncv9UvFVjqsWCp/nKguIFFFp92D2//7wAkLSmx9jqUzjt79WTXbSi1gUxvf5wE+
	4QQZW5Z/PmZuADV/avYTVugH7focphwPCx4aQ52sAxeBr6Joknir4jRTorZim36UyvN24Au6Qju
	tQrguPZK3InwbDhvnl/AX+ndMcTilodymhh/5n/UE5llm33rS+U/z0z0NKTEE/wVH5dNWHwfw/7
	AWER16z5JYgrX7BBGgeAHAQYGWRT/yvKv2FgnE+oW+JtP7AvOmZKugj8o3eNc6DLUfyn/pkdh2A
	d7IHf8wWQQqfR8rrMJvA/Y9uOjTDgQxbcap2AVyIcYaI8fM7Nr1br6ugu+pl+u7L4X7QNzIbIov
	uMdjuxPLZOJ1XcTV38VmQL0LS+/lq/bl00BOQLOLMgw==
X-Google-Smtp-Source: AGHT+IExMbpPYOqj6/d85+ArJV2HSSzEcZuVIRRwoBeeBgUYFCOCwFPnqdn8UUbPLEJ6+FKh9oGVmA==
X-Received: by 2002:a05:620a:f10:b0:7c5:57b2:2cb9 with SMTP id af79cd13be357-7cd0111870bmr2129679885a.26.1747060272830;
        Mon, 12 May 2025 07:31:12 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd00f4e146sm555031685a.19.2025.05.12.07.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 07:31:12 -0700 (PDT)
Date: Mon, 12 May 2025 10:31:10 -0400
From: Gregory Price <gourry@gourry.net>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, corbet@lwn.net
Subject: Re: [RFC PATCH v2 10/18] cxl: docs/linux/dax-driver documentation
Message-ID: <aCIGLu6fAOC8TPuJ@gourry-fedora-PF4VCD3F>
References: <20250430181048.1197475-1-gourry@gourry.net>
 <20250430181048.1197475-11-gourry@gourry.net>
 <43d957e0-f52b-4ba8-aa87-cfb8472b8b67@infradead.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43d957e0-f52b-4ba8-aa87-cfb8472b8b67@infradead.org>

On Sat, May 10, 2025 at 07:18:27PM -0700, Randy Dunlap wrote:
> >  
> > +A Memory Device is a discrete base object that is not a port.  While it the
> > +physical device it belongs to may host an `endpoint`, this relationship is
> 
> I have some parsing trouble with the sentence above. Maybe s/it the/the/.
> 

Changed to the following:

  A Memory Device is a discrete base object that is not a port.  While the
  physical device it belongs to may also host an `endpoint`, the relationship
  between an `endpoint` and a `memdev` is not captured in sysfs.

Thanks for proofreading and feedback, sending a v3 today with the TODOs
ripped out (can't circle back for a bit, better not to let this rot).

~Gregory
