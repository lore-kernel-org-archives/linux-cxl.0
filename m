Received: from skyblue.cherry.relay.mailchannels.net (skyblue.cherry.relay.mailchannels.net [23.83.223.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9336C8C0A
	for <linux-cxl@vger.kernel.org>; Thu, 21 Mar 2024 17:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711043761; cv=pass; b=QM2mtbSrRmyza6z75BVcmOoihgLpGgVRnVMZg+oCB+6gHIW0XbVA4gV1oYDN5b/K0LCGmzDOfjfLPVgYpnb+smAcRo9q3SsNtd9eE3WA6tdDYQm4j7gqBHmHWOWK4Q/3b7Dto6flpkv0EjED/kmkAlWJ+tLplyPlO9ZekcGActY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711043761; c=relaxed/simple;
	bh=PXE1TEcZsKPz9H2Ycxf9nTlCMTSWT4U6Hnp4AZmnZc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/M8s9DSKT3ndfELxBJ9nBuybfeAvTljy11XyQ4zsiRn1QNa91gpF/YKXFxns1P8kkhtqNqaVAxyoDLPFTNJnkdwyFBCKZgnKRKs4JwHTn5k4ahTGkiEgFZQrNtnSSPu9cj9LLg4ODQeZJCv7Rw3dkraFs0A5sLC5nvbMyLWdoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=q9iVGTei; arc=pass smtp.client-ip=23.83.223.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="q9iVGTei"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 37C7C7A1740;
	Thu, 21 Mar 2024 17:46:06 +0000 (UTC)
Received: from pdx1-sub0-mail-a274.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 8829E7A1ACD;
	Thu, 21 Mar 2024 17:46:05 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1711043165; a=rsa-sha256;
	cv=none;
	b=GToXjsMVinwgPWZnTjj6dTFs5Tp6Hjk1RlVH/9hXANO73UFgkyXUl6ySXLc3fxW5Z4zGyD
	GRqlk/dmMb/+GoIVRp/8j4NUua4bXusAWVMnvgsrmP2Djw/rRqehyjjNTJXk7XdHutjB8s
	XnhA6FahsRZ6yd/PduK5agooHNQ5bh+di5NcWEg40yR2Ve+ja2a1ShpEcXV/KhX8f4hV8x
	FvRo3mOMV7JRoTWmHr3MlezaqtMrrKM+lYcGwHEYxRp0m6qyp+UMXqd61km7KBYvlDryHW
	UCGB+xgInBUIujMGDpNm6EV5FY1spOznY4ftbkgkifzQLLDqexogEOZl6m0nOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1711043165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=PXE1TEcZsKPz9H2Ycxf9nTlCMTSWT4U6Hnp4AZmnZc0=;
	b=A2WheuvGUQNgbXLpJ8sLEDriz325tldDLcm/l6f7aZZucuLR9/3ozGJWdGneXlAE7Mwiif
	wOTYWiUYZbG9T2sKdPgf5Y61ElN65V6lIRbhcA4Ur8hx+g/GB/6ipAAeAvXT6UN0IAvkNG
	C0vhOtIwh45olv6r7IzKYdNAVTEOaOBnjKN8+IgU5pup1rLI8J/2ByzCQZ8zggISYRe+W8
	ukJYITbZRR+VT5yvonKhixe30cLGNueJNvwtuHAa5/DBA5/XhzyLMIE8kahEq1V9/6pXv/
	RedlCD4bzHZ5+P5nKvh0Lm4NJBaAi1/vTJ+sxFROK92JvWdnFT/vq73FuVyA/g==
ARC-Authentication-Results: i=1;
	rspamd-76c7995f89-7srpb;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Imminent-Cold: 08e17168600760e1_1711043165905_2612934878
X-MC-Loop-Signature: 1711043165905:1499911102
X-MC-Ingress-Time: 1711043165905
Received: from pdx1-sub0-mail-a274.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.109.159.228 (trex/6.9.2);
	Thu, 21 Mar 2024 17:46:05 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a274.dreamhost.com (Postfix) with ESMTPSA id 4V0tDD6jywzGv;
	Thu, 21 Mar 2024 10:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1711043165;
	bh=PXE1TEcZsKPz9H2Ycxf9nTlCMTSWT4U6Hnp4AZmnZc0=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=q9iVGTeiDbX2T/axZWc40lgaMe6XoGP8yNGH7Y4uScllgTcwGDP/I4rn7oqlCI6E0
	 gj3nsabJ8RJSzE2J5n9yLwlbi9i3sfEzNpsS9wfsCf8X7Hmc5JPoJUtZb81SKaJMoP
	 1ArM3K0kcDs3yxnxV3frsiaRyG++DWs7FSQeMs7MgXsR7cSrLJ56YGVbONmzhq6we5
	 dzjCkUAZbZFH+oFCnG7s3rqyrS7RCOT6s2AtMXXcsZ1BUvlEXqhFs1CIQock33OY2U
	 WsupdAJtuTBeGa62NpBy2dvB40Sm+R5aGP25V1IOU+K+vd43FdtChP2PjBZb4WnYfN
	 fNgVU/XV1DkDQ==
Date: Thu, 21 Mar 2024 10:46:02 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com
Subject: Re: [PATCH] cxl/core/regs: Fix usage of map->reg_type in
 cxl_decode_regblock() before assigned
Message-ID: <20240321174602.za3lip7dqehxgzzr@offworld>
References: <20240319181508.690837-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240319181508.690837-1-dave.jiang@intel.com>
User-Agent: NeoMutt/20220429

On Tue, 19 Mar 2024, Dave Jiang wrote:

>In the error path, map->reg_type is being used for kernel warning
>before its value is setup. Found by code inspection. Exposure to
>user is wrong reg_type being emitted via kernel log. Use a local
>var for reg_type and retrieve value for usage.
>
>Fixes: 6c7f4f1e51c2 ("cxl/core/regs: Make cxl_map_{component, device}_regs() device generic")
>Signed-off-by: Dave Jiang <dave.jiang@intel.com>

lgtm.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
