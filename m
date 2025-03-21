Received: from panther.cherry.relay.mailchannels.net (panther.cherry.relay.mailchannels.net [23.83.223.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1284A208A7;
	Fri, 21 Mar 2025 05:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.83.223.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742536136; cv=fail; b=Nv97+kNAA1vBrHM94RwIoxjmPALRdDQ/6cZA+JUA240gLzy+tnZ9V5BTyNBkcwSM5p4z7QWdLu4dnP5dKP2zmLMA+7ooUG8jnZm2R7DuqdU6ciTRgxBgTBHPChYoOc9upnWpFQJDUsMNrL8BS3pot/YEYaJ0E/RYcWWuvw5Zv7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742536136; c=relaxed/simple;
	bh=53FJt8Nl3aXBuorygGMCbOuRq+BG25RLd2YX5y4RzbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhKWRLOLATGllWel3j3rQzKZv/JRiy+Tu03Iv4EGgstztLieLws7YKdYfd1QtlyG+f0H+9C2pR9ujx7rji062WilCvWIMb8hlJnY5tuAEh4pfe45Zeqz/m6QLly8ryw4V6iVtPtxeNkeaRotKmZ6e3uy6gGE4krbFEE/xONUMxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=RHsqvk/1; arc=fail smtp.client-ip=23.83.223.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="RHsqvk/1"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 5A99C1A3DC0;
	Fri, 21 Mar 2025 05:40:11 +0000 (UTC)
Received: from pdx1-sub0-mail-a223.dreamhost.com (trex-7.trex.outbound.svc.cluster.local [100.97.52.66])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id D06681A4113;
	Fri, 21 Mar 2025 05:40:10 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1742535610; a=rsa-sha256;
	cv=none;
	b=KkOOAJK/RAPYuED448YYtciDVpjjGB5NkuOL0nfT5QX/20bjsWfwiwFAWRwKOWfps6XZGI
	1Bl88lbIzFQBbyHw+SvxY02iugHgeG9axX9JW12q+j6MlP2HiKaSejN/3713pkr4LgfZ26
	gkRW314A8SdlLcwaBtan4TF7zcN52CeTuaFCBtMj4tu5LQ4lX8UDBZgVK1vMvTo+DthVmr
	MXlybxob76sYS2IypL/mxBmdB+Xrsh9j93qQYC9wVrqNaefnESeDRBlsI6TMDE3Yt9ymNT
	U8dGst+XPyi7rJMRlY5I6+7Xmg2506bIzpxY7zppZYXcIvCARO8sOe5tiksgOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1742535610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=0PS513F+RSzcE7ufaJ1VV9J2RalenEzSdXL1qjKWnms=;
	b=OoYV9OvX8osBCWuo1z4lXevDHb7ctaR//ds0EAxfbEBLTOF69FTRHifaubz8qs/N/a3y5q
	Ka2MUzle+QmjX9Ky6A1sC2IpuwOgcEfFlD+gGGg7DOsBrv7S7k/7USrshax8ItDJwYHYrO
	WTiHUwerlAddn/YKgEQaFKowbDlWDpdES4YRcrG0hgtYvq6LbA//oA6lA8Dx1GSpJYEEIC
	8aLLNPqcyfV+c27nftJalilFAk/UqAa/AoyaDlSLzhqjFN+n/C9weQnOguqubUJh5yG4kI
	X46fnZTOygbig2GOAtRuGNu4q4JLixqCTIwudX1LNz/1ZGvyUyOJUsUsiuRVTA==
ARC-Authentication-Results: i=1;
	rspamd-67d8974966-r82qp;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Whistle-Unite: 26a4e5d0610e8f75_1742535611133_93697085
X-MC-Loop-Signature: 1742535611133:926574431
X-MC-Ingress-Time: 1742535611133
Received: from pdx1-sub0-mail-a223.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.52.66 (trex/7.0.2);
	Fri, 21 Mar 2025 05:40:11 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a223.dreamhost.com (Postfix) with ESMTPSA id 4ZJrrB0STTzJt;
	Thu, 20 Mar 2025 22:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1742535610;
	bh=BA6hsN3yvUC4+OlJ0/XH6ZXiSbYXeRCoV1wEkucA7r0=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=RHsqvk/1568KqhWp9X5bbEj2n24ZOEV1YOO8kcs6xbEmZ1jzhUy+wjOWy4iXFwFB1
	 7DGjQOe7gVErt6/XvFFTE8lRGU4hUz5a4cWnasX1+qM/yOqY3e0aykzzhtSgeFP22f
	 wX57AgpIyJqX5J8RNBYaWtKB+TUFgUmlqRdN5aHugGDAxkYskNhM+YT2JQ6y08PVvP
	 4OCW8J82RCXS203ybMuXuIf6idmlNwtmcclt7kSzlrzSg41CFhuiVKcjEfBHh1bVIF
	 VeMxFfESwGO6EnL8kLgjZH3s50sWkCsAoPgTcbgBiPVDD+PofVyStbF7l2LtJb2kA8
	 w0PDCKs3o1hzw==
Date: Thu, 20 Mar 2025 22:40:07 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Li Ming <ming.li@zohomail.com>
Cc: jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC Patch v1 2/3] cxl/pci: Update Port GPF timeout only when
 the first EP attaching
Message-ID: <20250321054007.fidkwiemotwqyui3@offworld>
References: <20250319035516.222054-1-ming.li@zohomail.com>
 <20250319035516.222054-3-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250319035516.222054-3-ming.li@zohomail.com>
User-Agent: NeoMutt/20220429

On Wed, 19 Mar 2025, Li Ming wrote:

>If a CXL switch is under a CXL root port, The Port GPF Phase timeout
>will be updated on the CXL root port when each cxl memory device under
>the CXL switch is attaching. It is possible to be updated more than
>once. Actually, it is enough to initialize once, other extra
>initializations are redundant.

It's actually not updated more than necessary because update_gpf_port_dvsec()
checks first:

	if (FIELD_GET(base, ctrl) == GPF_TIMEOUT_BASE_MAX &&
	    FIELD_GET(scale, ctrl) == GPF_TIMEOUT_SCALE_MAX)
		return 0;

>When the first EP attaching, it always triggers its ancestor dports to
>locate their own Port GPF DVSEC. The change is that updating Port GPF
>Phase timeout on these ancestor dports after ancestor dport locating a
>Port GPF DVSEC. It guaranttess that Port GPF Phase timeout updating on a

s/guaranttess/guarantees

>dport only happens during the first EP attaching.

... but yeah, I think this is still better, logically.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

(with the caveat that if patch 1 is not necessary then this would need to
be redone).
