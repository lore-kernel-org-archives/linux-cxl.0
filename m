Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E582D23A6;
	Sat, 25 Jul 2026 18:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785004666; cv=none; b=WidbUrV6aRfwYNnc4T1JR6IwSNJmX5rZXKMTXY3YfEoS0NOPk7/b5seIYU5mOJVCmIkgCMrWveQS582NZzW82TGZWDvdYFWWs+z5LiMQIUi+UZwFiKbVby5oZudC0CbQDGOWsB8wac8GEZ6DWhQQ49IPDzrCnQ78SwWSUV8sd6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785004666; c=relaxed/simple;
	bh=O+/rvfVZ/hpGQKr/Li3jQAD6Lu7nMDpUCL1/g/UESa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jt0vjcM+CEYGFh6L6ADLjTVpzA4c4siQu5iTNUxVmrLoO2Y8QEfz3c1iABEpYM5yBNZHtRqpCeatEQLxRt0gU+sXGFqtT3fo1x7RS11uf3i6p9pltw93fY4W+d4R6oBAKJufYx/HrmgusP2JQ7NOzjrepQsqp6y46JbSTuNhKc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=Qfy/lOrr; arc=none smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="Qfy/lOrr"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 01C3E381705;
	Sat, 25 Jul 2026 18:29:05 +0000 (UTC)
Received: from pdx1-sub0-mail-a251.dreamhost.com (100-104-248-96.trex-nlb.outbound.svc.cluster.local [100.104.248.96])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 837813815DF;
	Sat, 25 Jul 2026 18:29:04 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Glossy-Shrill: 51f31a361d76e03b_1785004144823_31124716
X-MC-Loop-Signature: 1785004144823:2148715997
X-MC-Ingress-Time: 1785004144823
Received: from pdx1-sub0-mail-a251.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.104.248.96 (trex/8.0.2);
	Sat, 25 Jul 2026 18:29:04 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a251.dreamhost.com (Postfix) with ESMTPSA id 4h6tfl6l7Tz105C;
	Sat, 25 Jul 2026 11:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1785004144;
	bh=17ZMbwMSK3BwGn6aN429OXbd/9ovce/RFTXcBNTB0G4=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=Qfy/lOrrBos7sP4J2/qT7+ET7RxJhEVuD4U5RCcqq/758hDQv/RmhWJLJRDEwtBi5
	 ML6oAZIuRpPvmz0LrX9P3+RWy4mCP1Uoaw78BY9B4KTdhL6plR40jNxyfaxZcoweH/
	 nu8RRzfhU3hvwX2u3stPX7kiXjpQJPpwFpXP6YFPaJG6pLwt7Uimc1Mhcmxph68CO/
	 Po8Z+dC+zb1Os6fX2AcicZjIWYnsWDphm5Stb2gecPv9OznbNXeRf2OcIcX5WszjvR
	 9Ap4RuuQ2Yg/4NT4hW7nBaPTnNR/YEjeFeKiBz1ZBjGONkRdgYNCD3KqFEVZifl3Fo
	 w6rDmWSX5g2XQ==
Date: Sat, 25 Jul 2026 11:29:01 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Mayank Rana <mayank.rana@oss.qualcomm.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com, ira.weiny@intel.com,
	vishal.l.verma@intel.com, alison.schofield@intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cxl/hdm: Enforce CFMWS memory type policy at decoder
 commit time
Message-ID: <20260725182901.tox6h4usnaxx23g4@offworld>
References: <20260711003341.2602368-1-mayank.rana@oss.qualcomm.com>
 <61531e60-0171-4d7e-b61b-ac0790a38ede@intel.com>
 <115d2157-d4d2-4897-a9c8-fe42fec0bbf9@oss.qualcomm.com>
 <41540b44-8142-4b80-b876-0ff3f7ddd619@oss.qualcomm.com>
 <e3021037-f674-4974-adbe-eb7564f0c4b4@intel.com>
 <eba0e451-3d8f-4426-9033-373e0ac9a440@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <eba0e451-3d8f-4426-9033-373e0ac9a440@oss.qualcomm.com>
User-Agent: NeoMutt/20220429

On Fri, 24 Jul 2026, Mayank Rana wrote:

>I review proposed Davidlohr fixes, and seeing that cxl_region_attach()
>will prevent this situation. Agree, this patch next version is not
>needed.

Right. Also per your qemu testing, please refer to this series which
reverts the window default back to pre-BI (just hdm-d+hdm-h) and allows
finer grained restriction control and user can explicitly enable BI there:

   https://lore.kernel.org/all/20260720233242.901544-1-dave@stgolabs.net/

Thanks,
Davidlohr
