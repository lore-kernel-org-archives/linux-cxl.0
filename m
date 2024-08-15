Received: from dog.elm.relay.mailchannels.net (dog.elm.relay.mailchannels.net [23.83.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFE217C9BD;
	Thu, 15 Aug 2024 16:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723739688; cv=pass; b=gf/KkTrQqsur3I6gILOj6cDJONkOUbZGAwTIGdTK31Ay2XkLkHxfhffVAAjDb8ZRG1ZIN1JL7bmHYHinKg1Cm/NLHSO92Szs3JnxWU8Gd0S0xvrhBsLyYkbx4kJ82gdfOow2jyr+IutYX6cF+roJTNU3ZZXE31nDbRCL6pRcEWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723739688; c=relaxed/simple;
	bh=y3c2VuHGmCmPcgmj9qh7EQBynd5WFG+1iOb/mRfYApI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqBTOpnBrwr0/KgvR4imyXIR2K9us2oDC348zWymvzqjt7whGxLHUxgcmzKwtYP7gReEBpl0CGsp1RElGSNuylCTg0p465moeLvW2fQ2DOBzeUeyjDfEjmZi+/7B//BNL7V1ONQE9jVqi/zoeaDpbH3JS2QURkCk2LWsvNLiorc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=H9Lg35ea; arc=pass smtp.client-ip=23.83.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="H9Lg35ea"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id EB74C545878;
	Thu, 15 Aug 2024 16:17:52 +0000 (UTC)
Received: from pdx1-sub0-mail-a275.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 79353546792;
	Thu, 15 Aug 2024 16:17:52 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1723738672; a=rsa-sha256;
	cv=none;
	b=TzXEZyzuecJ96qPEY16JbTTpB/Ce5xYsnkxhRvTlhrUEweIVQt42V04jdL0KPfpy/5rUUV
	i60oallBaVVB3xaHrZ7kqrItSCTXzrjbPRr9DDmnLyqkz96cmg7eGq+3PwDuz+H5PhpWTE
	aQ3hiFqXT9AHLS3cOyMdOJnYPAhyZaQU1k5+aynmx+F6nLljmevpr9M2cD9wLA4dDFxqUn
	NaNOsWkO1nlzEEsOPGRCalQZkGJ761SwY5R03coeA+mokcENukISsFXUNiarWNTWNivJTo
	eN3WvljsZ//Jqq50+9qpsR9IlDki/5ghWzyoUW3sdqJ9FakiEr88DJzLTf6bOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1723738672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=bxcaS4NtjaqXYf1JS7wH3Qq2ogFTvYg+LmqMf8tx4CY=;
	b=5BcranH0jDr/XwmQhJ1rtR7a990j2kF1TurmjTV0SvZSMHNzmZpTjv+SGvMPqKFOzdSX8q
	069t+TnaZEOVMDMMOVZH7wt11oQnXxcTiaJhDEbwQeqYh27w82pFqviwk0Isk5AXqvIwgw
	eHSZAfqz2WX9qTy5tcehLav5gvgSZNKv3TuluWYIbzvfpt4KcV9zIPfbctKaOh4aPtLDWT
	15m9hBRcFkKUPW/kSFlsrgn2OelfP2ggDEbH2jUGnPI+xleS0Z9+2H+fAwio/SMNgXohW/
	D1Csb0yNzkRl5nxU2q17Ko+hDJOQ8laR95gCdv//Yut9MD5UiP2uKdslRCrSWA==
ARC-Authentication-Results: i=1;
	rspamd-587694846-pr4lb;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Desert-Whimsical: 4568c67f00c511f9_1723738672785_3584071105
X-MC-Loop-Signature: 1723738672785:3084883871
X-MC-Ingress-Time: 1723738672785
Received: from pdx1-sub0-mail-a275.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.117.75.38 (trex/7.0.2);
	Thu, 15 Aug 2024 16:17:52 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a275.dreamhost.com (Postfix) with ESMTPSA id 4Wl9Jb645zz6F;
	Thu, 15 Aug 2024 09:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1723738672;
	bh=bxcaS4NtjaqXYf1JS7wH3Qq2ogFTvYg+LmqMf8tx4CY=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=H9Lg35eaQkjVFxrjhevYRKQAvfa3jCOP9cWjFsWhOtKDDnimUw3oBH6k5TC3dYsed
	 uXQNEa+lOuF+IxYgPykN1+tPPw18faGyaLO8xKlzkiEA+Ge1gASI1MB1BpD67mbM4q
	 dc3JV4kwTZ55Go9EMltTvA3+izrloZQwWu5Y75iaSOs/Wa6gbWDTPduBE31BGy02xu
	 G50s4gM0mWH8dLXi+heaN1JOVdDZCrbxIRrNlOFwYKeCIN6bU5DLPbhBp9ebPGyjR7
	 IgJ1JT/qmRVr1MDeA/WGX+tNreHdOOifckxz2dJjfTaV7YbhO8At+wdX3H75/F7eAC
	 +VcmKvErwDIHQ==
Date: Thu, 15 Aug 2024 09:17:49 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cxl/region: Remove lock from memory notifier callback
Message-ID: <20240815161749.hb2zzwam5rieswws@offworld>
References: <20240814-fix-notifiers-v2-1-6bab38192c7c@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240814-fix-notifiers-v2-1-6bab38192c7c@intel.com>
User-Agent: NeoMutt/20220429

On Wed, 14 Aug 2024, Ira Weiny wrote:

>In testing Dynamic Capacity Device (DCD) support, a lockdep splat
>revealed an ABBA issue between the memory notifiers and the DCD extent
>processing code.[0]  Changing the lock ordering within DCD proved
>difficult because regions must be stable while searching for the proper
>region and then the device lock must be held to properly notify the DAX
>region driver of memory changes.
>
>Dan points out in the thread that notifiers should be able to trust that
>it is safe to access static data.  Region data is static once the device
>is realized and until it's destruction.  Thus it is better to manage the
>notifiers within the region driver.
>
>Remove the need for a lock by ensuring the notifiers are active only
>during the region's lifetime.

Agreed, this is better.

>Furthermore, remove cxl_region_nid() because resource can't be NULL
>while the region is stable.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
