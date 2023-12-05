Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="EtE+7iXt"
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F55C6
	for <linux-cxl@vger.kernel.org>; Tue,  5 Dec 2023 10:59:30 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 4EE5F421C4;
	Tue,  5 Dec 2023 18:51:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a281.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 013C44255E;
	Tue,  5 Dec 2023 18:51:07 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1701802268; a=rsa-sha256;
	cv=none;
	b=9zxecHBdlDYW4fOyC37mn2L8ft0jSt3UD8reY5Le0VQ0X8kYxbCr2PnbSJMPkAAHLDaBMZ
	i/Yi9qzvhAExdOvemm3DdpFPtWi/+7xD0lvs2FjQwmCBz9CjmD9yyPFuiRfzRDJiLj4zX9
	epni40hX4z8pDiQDlJCvJBnP924E8n8kgETPEdLbWx/tNyL2CLYb5OYBTiyxZOok5Umsz0
	9Cy+ZjEzU6oqy0fp1Rn1KkXAQbdmwJ1o/KsCEhuAush4Q7OzpN6qusV+OtyKvLSPdEbpiS
	CFmvaYsQ2d4xwb3JuNvXLbgXvfbmB4dKg69jivK46NcouHXQhZq4oCiZuQ23VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1701802268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=TMo7dFsJXgaopSPVnTtgb3V7Du9hLP0dFmoHzDqzHac=;
	b=zqMIYpzFD8VUo1ZAsGubDqetAtoDnLV6huhIuawFaqsrZ6N26rS4KI/SdW1iEVv7DInO8/
	kYECEztctr45XO30WizVEyiK6K8XdYLae8GEYvyD0bxcxh+CxRoTFktnqFfZp7Bp5UkVda
	j1bEd8dRz+50mr7x9uXdvYaSfn/nQnMJvRVMqEpMTGlGkgFcGCGCQohGjjknjduYj9gA34
	8YdqHFKamG7VlkDlH5qpMkRXArVrgm9YmATCtfXkpFcs0Ja8KPeAp5MU9d2BJsBymbY1mq
	32V7oDA9QmIHItBG4TscdzL697ESS8tk1DOx7guKMbPMhlRdxWghkHWekOVQYA==
ARC-Authentication-Results: i=1;
	rspamd-696ff67dc8-7xhck;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Plucky-Suffer: 679c76621a9752b6_1701802268123_802674693
X-MC-Loop-Signature: 1701802268123:1753170591
X-MC-Ingress-Time: 1701802268123
Received: from pdx1-sub0-mail-a281.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.118.156.74 (trex/6.9.2);
	Tue, 05 Dec 2023 18:51:08 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a281.dreamhost.com (Postfix) with ESMTPSA id 4Sl8kg4ZjZz3l;
	Tue,  5 Dec 2023 10:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1701802267;
	bh=TMo7dFsJXgaopSPVnTtgb3V7Du9hLP0dFmoHzDqzHac=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=EtE+7iXtIzbP4GBSUIezcGW2DxZmrsIOTx7LjfKyNiAIKBpZkblxn/uuKc0sutAmJ
	 2wGUIgl2NM0nbIqju7T6sYLynTJC1UYScNgLNLKEXJObcAAo6AJvb1GtmTxCU3AktZ
	 LzSp0GV0ZWSLV0KOTngY1NppbXNIg3vajJyZtou+KHhlOk4qGxWsELnPquavPJu1Z5
	 2KrA0E57ykfh0PHG1OgK8DY80eO9Ez07H83gBKmzEwuNaMwM6orBLQqlyIS92oKasn
	 167xTY4U1A3YR+UrdpM4s/RIlDGGwwFsSq6JAqekRXebrdp7MXcGxRbqCaMsveQKeZ
	 MDOBvTBBrR1hw==
Date: Tue, 5 Dec 2023 10:51:04 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jim Harris <jim.harris@samsung.com>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH RFC] Add "uunit" unit testing framework for CXL code
Message-ID: <20231205185104.u3ghhid7nh7vxbio@offworld>
References: <CGME20231204193337uscas1p24b1959cf528b02b8172736a61807fff1@uscas1p2.samsung.com>
 <170171841563.162223.2230646078958595847.stgit@ubuntu>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <170171841563.162223.2230646078958595847.stgit@ubuntu>
User-Agent: NeoMutt/20220429

On Mon, 04 Dec 2023, Jim Harris wrote:

>uunit (userspace unit testing) generates wrappers for kernel source files
>which are compiled and linked with necessary function stubs and executed
>fully in userspace.
>
>Existing unit testing frameworks (kunit, tools/testing/cxl) have some
>limitations that uunit alleviates:

Looks very helpful.

>
>* mock referenced functions without requiring modifications to those functions
>* mock register accesses
>* does not require execution in a running kernel
>* no restrictions currently on CONFIG parameters
>  (Note: some CXL code cannot run in UML with kunit due to dependencies on
>  CONFIG_SPARSEMEM)
>
>This RFC contains some complex unit tests for core/region.c code, as well as
>a simple core/hdm.c test showing how register accesses can be mocked.

Documenting these tests at a high level would be useful, particularly as
more tests are added. (actually I think this is your todo #4 :)

>
>This RFC depends on CUnit, which needs to be installed on the system prior to build.
>
>To build the unit tests:
>
>  make -C tools/testing/cxl/uunit
>
>To run the unit tests:
>
>  make -C tools/testing/cxl/uunit runtests
>
>There is a balance currently between creating stubs for referenced functions,
>versus just building and linking the referenced source files directly. For
>example, CXL uses xarray extensively, so we just build and link the xarray
>code directly into unit tests rather than creating stubs for xarray. See
>KERNEL_SRC in the Makefile for which kernel source files are directly built
>and linked in this manner.

I would say that just making the thing bulkier is better than having to
have stub wrappers to a lot of core-kernel machinery. This is particularly
the case for having this under cxl-specific paths in the kernel source,
instead of a general framework as you mention.

Thanks,
Davidlohr
