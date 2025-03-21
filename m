Received: from seahorse.cherry.relay.mailchannels.net (seahorse.cherry.relay.mailchannels.net [23.83.223.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EE6B664;
	Fri, 21 Mar 2025 05:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742534602; cv=pass; b=n9s5GClSbpUiGP1aBUxqyi1wmPSJ9cZcSqEX0JdH3JVvRLldHEWanXyInSbLtWGk+XGdh98unhc0XLLK5pu4dzBrL05R8CQwE5wf/AFAFRK6nNd18mXYKR8uJcrinw+divwBmUUgaiMdFLtNr9/WABRKwcqULGXBjwLPTtOOT4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742534602; c=relaxed/simple;
	bh=t1naq+VCEMf0ogURBrW9QjucvZMdFB3JeOJdmjydhZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUn2+4tFuY1PkSqcxTAXnWdbkA2tAxrUi6ynt4ywb181ieEKkIkOMC1Sf1atjP+r8hOs40DeSVzqlNuFQZWwW4NCrpclY2cMkyfjdVFzvCsBmPoXcmjZe1j+Ncqr2WBNkajosC/Rr04YN1+RP1OaatvVv3sulXFF8woYkegbOco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=X+Zzo/3m; arc=pass smtp.client-ip=23.83.223.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="X+Zzo/3m"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id F2EE121705;
	Fri, 21 Mar 2025 05:23:13 +0000 (UTC)
Received: from pdx1-sub0-mail-a223.dreamhost.com (100-118-196-111.trex-nlb.outbound.svc.cluster.local [100.118.196.111])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 8E69B20D49;
	Fri, 21 Mar 2025 05:23:13 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1742534593; a=rsa-sha256;
	cv=none;
	b=5o4My6UazYdZWIoblHdCnhPo1KaCeyncsficcjUzTAas5Z81VGpJboRRmeRIgOoR3vwwmw
	O2/S37I6vbl3naBBOKmh8MdJE/tIm9z8dp7OMPNBkknnmIjIAHIyP2cQ/Lj9bWzxKyEIE7
	i85qQZQvSo1m1ecc7mamSPVB1HNY5wtIjXwPAuUy+SbkqnHMuBW7nf2HRvuv+u2zxZtarz
	V5yZnPmQslriZgqTvucZygezhPwkexDhgv7hxRybq0BDGIkqZQDaVamDbbTz6QiLdR8lQ8
	/Idb9KXpQ6ylFXMM3H74nisihbr+bXSElPtnipUWwY5W2U6n+9NRCg3ssYjqQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1742534593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=t1naq+VCEMf0ogURBrW9QjucvZMdFB3JeOJdmjydhZ0=;
	b=GvKaoqwKYSs5MZRZVZ/+pi/XU2IhUhCd99/vMbM2UhOmV0VxWwjn1MTJALwmGW/7oNR5LE
	BivP3jJLevtQP4lItmlSJPThDlM0N+z3W/US+LHF0BcGUMsJGD9tDR16z5G19eWKF4bAbZ
	ydyBYbdoN9nSesfJjASR9SUIoxwfJUOAbIM1J97bnQcwHND+2cUJaJTALAjS86hGIF/uoL
	P1QvnWInppU1bjSHN8MI8sAWiKjgz2JjI6OSZFWE+mkBsh9Jepib9UyFsWZDnZ39eJ+6+h
	jRuGmZyx48vVKneX/gBKLMSr2moRHnrK1XWxm9HYEKImsgrnVJJj53NzSfQDNQ==
ARC-Authentication-Results: i=1;
	rspamd-74d566c845-wkfks;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Shoe-Illegal: 7fd6764676d829a3_1742534593843_3088180186
X-MC-Loop-Signature: 1742534593843:2888225149
X-MC-Ingress-Time: 1742534593843
Received: from pdx1-sub0-mail-a223.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.118.196.111 (trex/7.0.2);
	Fri, 21 Mar 2025 05:23:13 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a223.dreamhost.com (Postfix) with ESMTPSA id 4ZJrSc6sFqzZT;
	Thu, 20 Mar 2025 22:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1742534593;
	bh=t1naq+VCEMf0ogURBrW9QjucvZMdFB3JeOJdmjydhZ0=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=X+Zzo/3mWBvQGMN5MFcze3kcDpjb4ryN0Dwbv90Wr/sXi0ycz4imzJufFIhez2Knx
	 AJmmEfON1V4KP5myMuuPMLQl15XXiM+ZQsh+uzGq/6muPlPW3Gb7+IuS8gOFzMvA4d
	 J1iouYQMZzDjiEJqTBKimwSoTUR7KiDVS6H/sgedpvT7RZrKt+bzgWtOXdAq/zLJJe
	 RdehBluLhEfF2SNEjbcBLgPTPVHsjp1dqUzUiikmINmMOr/tyAlu5g7k3v2a8JQ+Z/
	 NbCYvCH0/24SMZYXZyVc/wSTaSO1dvkSBF7ywfNH33J2IH26F4hP72eW6aVclhepAG
	 8slb6/dtMQ7tg==
Date: Thu, 20 Mar 2025 22:23:09 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Li Ming <ming.li@zohomail.com>
Cc: jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC Patch v1 3/3] cxl/pci: Drop the parameter is_port of
 cxl_gpf_get_dvsec()
Message-ID: <20250321052309.qkhlyabmcgbxtmtf@offworld>
References: <20250319035516.222054-1-ming.li@zohomail.com>
 <20250319035516.222054-4-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250319035516.222054-4-ming.li@zohomail.com>
User-Agent: NeoMutt/20220429

On Wed, 19 Mar 2025, Li Ming wrote:

>The first parameter of cxl_gpf_get_dvsec() is a struct device, can be
>used to distinguish if the device is a cxl dport or a cxl pci device by
>checking the PCIe type of it, so the parameter is_port is unnecessary
>to cxl_gpf_get_dvsec(), using parameter struct device is enough.
>
>Signed-off-by: Li Ming <ming.li@zohomail.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
