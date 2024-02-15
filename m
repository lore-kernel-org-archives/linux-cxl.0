Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB0212E1C7
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 18:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708020517; cv=none; b=GQw9J1LJmngIswiHl18Ror7NQbZeA7ZsoFGQtClxcyq3bn3jtgQKWRfQEo2phCMJNuPGBhR1iB0c6pdavFaZru8I7i/2y/YpRf2FirBI9e1RDktz+h/BsJH8iEj5HcdlqjM/rMuc0y4eWPQH04lJsvZik/F8+GkLjFWSJcuEC4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708020517; c=relaxed/simple;
	bh=pbpHwruiK/pnccrSEhfm0NNGJ/Lt/RcKwyg9KOFOLRE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+wkgQQezH+dQ9KUJvWVIMh4vKjZU7yEkjaJDt4YKXD2aXsrT3nYwuLOVm7XpQ+zut+wPiGQtPjVedHXWSqwFJ94/nkep59xOM9bPVWW5RHHfOzYtmD3DdQLTe2ZGtQTzxIZP2ZJFgv2pMYuJSs9xWrCy8YMh4wZYqU4rekX8Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmA2d0ZN; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmA2d0ZN"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e09143c7bdso789674b3a.3
        for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 10:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708020516; x=1708625316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vkhWEcATpjd0JyArKV0zT5GO4Ya9CWDNjFR6I4NE9CI=;
        b=nmA2d0ZNvikRfkiUBDXp0uk8sX2XtBkw1Zd1/VWO6OQ0wUnrSS0ST9/KdXBrH729l5
         65hh6nUh+8sCUnVGoG/i+iBKr3GjjWAfP5R5Wpq/qD+imsojWYyczPrdxmKpRtJZHmlQ
         qZQ09ZIBr6nRUtz7+WMjV/gNL3DMGU8qsXGcBJInZ5gHrGZgySAAAwK3wmC3Kka7sB7d
         Q8Z4cd407gvtUW1yFIriBXyS13EBvD7eCCkHVLOYjbXfIycuNDedQDHzMnNeM5p9Y8xs
         SYZxU8Erjs6RO6V5UpZri/MxcX9d4/SDCxp/r+oXaTPNFhLIRJ1uMUft6p/LU2L8gaFP
         0nLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708020516; x=1708625316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkhWEcATpjd0JyArKV0zT5GO4Ya9CWDNjFR6I4NE9CI=;
        b=sI7OZyROLnLk8r7m9/9qsdoFCzJ6FfxkyBaEIPPYxtAfi+w7TZazOdprww67qye/bX
         U27K8SxARqrVOsu5Zvqh3WwSz83xDwhkcAFI+3AcJWJG282E9l9tKLHRDmXhsRxKMCP6
         icneXlE/piYdCTkaFrbSoS2LdJG1NQKTja0O42aJcSSe0NQJHaRrApv/o16d/wuZZM17
         YmleUE2fNWNyR/DAxGUwD8bvVdZXCfKPAWewzdElKhYfcGBTwm2jEdicmVHDI0fyHSMR
         o4WsSOlbsfbaHkOE/Vju1AZXZDqgBeUtJh+wt+rD/LPQQ/IXcoSf+uVWBFUzRq8AlLMT
         carQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHLz2ToVydprQOdbOLV5qPGMmQr/tb6cclIAATYYcWTaiiNaJV51GWDJerRASEn9wPb9COOUoru3HdmCFheMgSmtdDPux1k8cP
X-Gm-Message-State: AOJu0YwqPY7j9RrnB79EW/abtqwFoLlr3m80fV23cs5xc5EXTksXchbT
	CHmL+Bvu59ob3k9VVhJxZqtXJ4SvesGv+RjhyhlI+eaLK+glGyOS
X-Google-Smtp-Source: AGHT+IHjUt/euppS4Vd2r5fZl4bAznuh0HSPey8NrtFnRZP/Yf4hJdWquREd8W09/MUbawooZwT/fg==
X-Received: by 2002:a05:6a21:3982:b0:19e:a1a3:b14 with SMTP id ad2-20020a056a21398200b0019ea1a30b14mr3897878pzc.1.1708020515607;
        Thu, 15 Feb 2024 10:08:35 -0800 (PST)
Received: from debian ([2601:641:300:14de:5279:cdf6:aaf1:e09c])
        by smtp.gmail.com with ESMTPSA id m189-20020a633fc6000000b005bdbe9a597fsm1707740pga.57.2024.02.15.10.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 10:08:35 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Thu, 15 Feb 2024 10:08:33 -0800
To: shiju.jose@huawei.com
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	jonathan.cameron@huawei.com, tanxiaofei@huawei.com,
	prime.zeng@hisilicon.com, linuxarm@huawei.com
Subject: Re: [PATCH v2 0/3] hw/cxl/cxl-mailbox-utils: Add feature commands,
 device patrol scrub control and DDR5 ECS control features
Message-ID: <Zc5TId-xVNl82xbJ@debian>
References: <20231124135338.1191-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124135338.1191-1-shiju.jose@huawei.com>

On Fri, Nov 24, 2023 at 09:53:34PM +0800, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add support for the feature commands, device patrol scrub control and
> DDR5 ECS control features.
> 
> CXL spec 3.0 section 8.2.9.6 describes optional device specific features.
> CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub control
> feature.
> CXL spec 3.1 section 8.2.9.9.11.2 describes the DDR5 Error Check Scrub (ECS)
> control feature.
> 
> The patches are available here,
> https://gitlab.com/shiju.jose/qemu/-/tree/cxl-scrub-2023-11-14
> and is based on Jonathan's branch
> https://gitlab.com/jic23/qemu/-/tree/cxl-2023-10-16
> 
> Changes
> v1 -> v2
> 1. Changes for Davidlohr comments. Thanks.
>  - Changed CXL SET feature data transfer flags as enum.
>  - Modified pointer supported_feats to get_feats_out.
>  - Removed an unnecessary branch.
>  - Use MIN().
>  - Move setting of hdr.nsuppfeats further down.
>  - Return CXL_MBOX_UNSUPPORTED if non-zero selection flag is passed.
>  - Add more IMMEDIATE_*.* flags set_feature.  
>  - Corrected a spelling error.
> 
> Shiju Jose (3):
>   hw/cxl/cxl-mailbox-utils: Add support for feature commands (8.2.9.6)
>   hw/cxl/cxl-mailbox-utils: Add device patrol scrub control feature
>   hw/cxl/cxl-mailbox-utils: Add device DDR5 ECS control feature
> 
>  hw/cxl/cxl-mailbox-utils.c | 360 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 360 insertions(+)
> 
> -- 
> 2.34.1
> 

Recently, Jonathan has updated all the specification references to align
with cxl spec r3.1, so for the next version, we may want to also do
that.

Fan
