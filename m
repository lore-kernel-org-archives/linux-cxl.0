Received: from silver.cherry.relay.mailchannels.net (silver.cherry.relay.mailchannels.net [23.83.223.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7E71AF0B7;
	Mon, 14 Apr 2025 23:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744675109; cv=pass; b=pV7r4eiwFPrU030IHnPavrjw5pbaUf4viJA8ZEvpsSNqsgaRS78322jZrlIR1hGmZ6Emetzv5EJOJ9+TRVfqaMGRDRVJ7A6Lmnm3U49eTFTEUwUGYpn+ZoRguaeUqzdqWK05M6DBrlNlT/8VDWJCbnLICACe/USUrtyzy0v7muY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744675109; c=relaxed/simple;
	bh=fa+0IOin+pptz4QlD9LOx09qql+Tep7UM1Awz/+GJv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9bqF9VPQ1vQmXa9ytEpeKzNkgKKIN4CHTSTTZFBn0qCgSohGiNmbIVYqk70bJetm6MFJoz0psa8hUSwBfer3eMbJ9xyT3hJxQLY3IDHRqLFixmQ4mgSakCWuAWuDYBnUYOeEWgwCeMAqppnC+zeSBvQQHK6mvkVWjrkjMkybHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=d+m1/ACL; arc=pass smtp.client-ip=23.83.223.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="d+m1/ACL"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 628DC23964;
	Mon, 14 Apr 2025 23:58:21 +0000 (UTC)
Received: from pdx1-sub0-mail-a240.dreamhost.com (100-103-65-62.trex-nlb.outbound.svc.cluster.local [100.103.65.62])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id D328C2395F;
	Mon, 14 Apr 2025 23:58:20 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744675100; a=rsa-sha256;
	cv=none;
	b=TMJ1cLxkdwWTeyYNRur2N9bRpiE2wduvITNEzkSd1XUdo2u65UHL0EToLtxJmQbqRmXgsI
	suFVnyTBPq4eDJiG9j+zSKrA7syvzLWDf0s5Ws7u0mlYD8ZzfFN09ramTbSHrU5Hm/1oWh
	ec+M4IvBDXx8bswXKHUHeNT8YEAJVKGLGmoswF/Ioakhfd/8Peng10x9nOxTIqzb5ft0p6
	ilEs9IImtNsWZlMDgjTOKsnf3IfjB/+vnch58Pp7QXc4c1iZ8QHeTYjOO5O9KWTw9op9lJ
	6bxSb2AqmElmaRzma69O/RBnf0dissvoZkKz7AD/WrHoQfoOegPMGXavF8pXlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1744675100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=qyE4vyrBSstS2lmJiwJGSdf46iiVL8EcZkAUWMTrMTI=;
	b=AqqW9sHNVBtlxAccFP6lczn/o7nNP7nzenGl6RBcNMt0cTPCSNvzBZQ67HCLC1/IPYM2JD
	w3QuxNeHpHw5VPgtcr9NLVvHH8JdKRDxxd84rczcAlv8HGRe1Nbc7nDquerwRqsXdEDsAG
	t9JSmCmcAy9ZLAc/Kzh0gqx0T0msPAemGPTZusMFQTHKz9dnpcPwVXeD5XcoRXpmoAetyu
	Au5L0QCaYEd6Cl8s34j1GjfNIXhLmIRXSDOGMhFKLDkIGl58J/Y7+DkPwZNoXOSmhctSuq
	Ko/grIUk5LvfPdckat/gez5vEeEZECuTpyJdmFlkXD/cUFzkvq20DTQbtYb/1A==
ARC-Authentication-Results: i=1;
	rspamd-67f59c8b45-rr4bd;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cold-Little: 75774d7800471a73_1744675101151_1694739444
X-MC-Loop-Signature: 1744675101151:1592274610
X-MC-Ingress-Time: 1744675101151
Received: from pdx1-sub0-mail-a240.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.65.62 (trex/7.0.3);
	Mon, 14 Apr 2025 23:58:21 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a240.dreamhost.com (Postfix) with ESMTPSA id 4Zc44D1j0WzF5;
	Mon, 14 Apr 2025 16:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1744675100;
	bh=qyE4vyrBSstS2lmJiwJGSdf46iiVL8EcZkAUWMTrMTI=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=d+m1/ACLHfhZe4sKLPvwq4bKOG7ZDEoNbLoJie0H3BfL62jx1EhUUZ8tXLp6U8ASy
	 b7ZaXNJcRMWQ+45sJAHVX03+5OmUrzjDTT3+Nm8K7zC7vs9djlPiCGjPjcwDwMA/g/
	 GgD8uvIzaKBhJScYgDbTDrG1l8cPZFs9dZ65GuSanZahDjwkLtkUbYAXat4uOcXIgP
	 9qjFSqIzdCuvQtVWhZ2uxTTJoRMukBlsujl3Gh1thYwmDMiG0b2H7Mnfx8xbhr0OSJ
	 wuDAPSZzLBjf8++6TqZYa3OW/RgPEGgNT9pGvQ68B/nIjWvosHltgYxUl2yzH3gtyM
	 dNcD/yZEazbOw==
Date: Mon, 14 Apr 2025 16:58:17 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Li Ming <ming.li@zohomail.com>
Cc: jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	shiju.jose@huawei.com
Subject: Re: [RFC PATCH 1/1] cxl/feature: Using Full Data Transfer only when
 offset is 0
Message-ID: <20250414235817.hu4bpvldk2yiayts@offworld>
References: <20250409024825.510632-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250409024825.510632-1-ming.li@zohomail.com>
User-Agent: NeoMutt/20220429

On Wed, 09 Apr 2025, Li Ming wrote:

>Per CXL r3.2 section 8.2.10.6.3 Set Feature(Opcode 0502h)
>
>"If the Feature data is transferred in its entirely, the caller makes
>one call to Set Feature with Action = Full Data Transfer. The Offset
>field is not used and shall be ignored."
>
>It implies if using Full Data Transfer, the received data should be
>updated from offset 0 on device side.
>
>Current driver implementation is if feature data size is less than mbox
>payload - set feature header, driver will use Full Data Transfer even if
>user provides an offset. Per above description, feature data will be
>written from offset 0 rather than the offset value user provided, the
>result will not be what user expects.
>
>The changes is checking if the offset caller provides is equal to 0, if
>yes, using Full Data Transfer, if not, using Initiate Data Transfer -
>Finish Data Transfer.
>
>After the changes, all Set Feature transfer scenarios are below:
>
>1. data size + header is less than mbox payload and offset is 0
>	Full Data Transfer
>
>2. data size + header is less than mbox payload and offset is not 0
>	Initiate Data Transfer(with all feature data) - Finish Data Transfer(with no feature data)
>
>3. data size + header us greater than mbox payload with any value of offset
>	Initiate Data Transfer - Continue Data Transfer - Finish Data Transfer
>
>Fixes: 14d502cc2718e ("cxl/mbox: Add SET_FEATURE mailbox command")
>Signed-off-by: Li Ming <ming.li@zohomail.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
