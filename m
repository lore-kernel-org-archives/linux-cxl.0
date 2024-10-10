Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D069029A2
	for <linux-cxl@vger.kernel.org>; Thu, 10 Oct 2024 06:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.83.218.249
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728543123; cv=fail; b=Yc8zKpR6JUAQPj9w1kxYlZjp3Cz3Lc/TH9vNjrSqI0dgB7mq7g3r2AFgNeyplrZF0dM2DoZeLmFQA0+i1LOCwBC+Fx4GYp1ftmfK82ZwlmOn5tz9YlvXOXoDb5VLthvlaJa9KmcrUi9ezYc3+vAScSGWcNyrmQbYQTwenvYRmgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728543123; c=relaxed/simple;
	bh=SF/+0m+5RDcNnf5z+mPYnc7i/Oz+Ns5k8EbxG8ZmHeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLCwXicwdTgHAbvPkNm09lwS7S2Pya1StT9SXFqTub4DB2RyVMlPE1RSrGa0rXS1ofHSErRK90qAPEfaSEXS8v4i0ftjoLO/WX7zzAsF/kEm9EKIBFoeuEKo2Pzrd+rPznXQnUBTZaQsQweeqGpKzUQ3Q34ubKVRr3gjRN9Ry/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=SYjSA4sT; arc=fail smtp.client-ip=23.83.218.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="SYjSA4sT"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id E1A21C2182;
	Thu, 10 Oct 2024 02:47:03 +0000 (UTC)
Received: from pdx1-sub0-mail-a216.dreamhost.com (100-96-87-165.trex-nlb.outbound.svc.cluster.local [100.96.87.165])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 76CF5C2035;
	Thu, 10 Oct 2024 02:47:03 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1728528423; a=rsa-sha256;
	cv=none;
	b=pf4ntmPR0qK7dSkXfJlWGDdHSUaLWcra3bcnblP5KdrI4ZN4U8xM0uE2dWyK1d3dPZcok6
	1itH3TAZf4GwZSOYhnHtoDiQzVWtj7+uisPxBbIGhK6sfw0YfgMwR8VP5YXH7ERHq0cJDP
	OETxYEbTAMzQNKskbkTndLwB9ME9e18YC8aW7PXnOE86/TcN7gt+ZT/tjunkYv+aRiQnOY
	49hPMWm/ALuFGezCtQ0I6YhuqJLdPDBzRbADc3dnQM3s78GBOi5i+jyMI0YBouMZzNbutC
	O7/np2r1dx60NloeYpK4OumJyquvdQzykxtQtk9g9zBL5e2IY+2aPhvXw0DfIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1728528423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=VpiZrJ2AZyuadMUuefQ07Cxc4uOhr1dNO1m1BODmLzE=;
	b=vfS63dbljB3VcIRH4eqGXLTpaCQ/XNbAQadN/588LVccgbU8Lo3fFLgeAMUTQqnqKx3XuT
	p4N8b5p8z7BveK1qDPzxCZqeSIcAcGwzfHAqxIhHCSwdwoKWSFQeo1IkudG4yHHmuNq8BJ
	ZD1eRxLHTbiCLychM9P86t317OAset6AqP35T4Qn0ErYkdYw0otYVuXY55QBIIchOhEk31
	A/odGO7geYsrcWGCf1KC3XQBjv5+b91xK5bkwbdcKZyCjd2K8MZsPrGcBh8CMfwnp7Py75
	QEtVsqFgG9cH/gPcYYjqO1tceG9M+7+G0Ppwpe06aAw73SmvzVcNPcWrh8Kiuw==
ARC-Authentication-Results: i=1;
	rspamd-5fcd6bf96c-tz4fs;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Wide-Eyed-Ruddy: 0247abe762810d08_1728528423743_902782240
X-MC-Loop-Signature: 1728528423743:1752296092
X-MC-Ingress-Time: 1728528423743
Received: from pdx1-sub0-mail-a216.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.87.165 (trex/7.0.2);
	Thu, 10 Oct 2024 02:47:03 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a216.dreamhost.com (Postfix) with ESMTPSA id 4XPDgB6D3dzB1;
	Wed,  9 Oct 2024 19:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1728528423;
	bh=SF/+0m+5RDcNnf5z+mPYnc7i/Oz+Ns5k8EbxG8ZmHeE=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=SYjSA4sT9Ifpec607obuS5VyRufo3OFSlxYGjw+awOJeok1mk8VOGuWnEWejEziUe
	 dR065m5UufE/QC2cxpZxkFD2AVR7I1tfTBQTBlIXdAQgeLxc82YoT/BBL1RVJiISkj
	 4Ba+bcE4mg7w7eBGpaNGkUfzLx1RQsx8pNpeDB4aLqzGPE2IrU3+i1LD782jJtqiht
	 6O1KT6L6YUJMjzou9jbkzO2B8MGR4ioWq930hpV5MneOcIIao8xNTCB4btpWJ1ITFE
	 tS+9HrF2IeVn5lTjfTi2tWx+EJQ0wMJCKY0KhjNgVmNDNI6aR+qDZC1RaTNZkUJg6Z
	 O/rqhT2wgCs3w==
Date: Wed, 9 Oct 2024 19:45:05 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: dave.jiang@intel.com, alison.schofield@intel.com, 
	dan.j.williams@intel.com, ira.weiny@intel.com, fan.ni@samsung.com, 
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] perf/cxlpmu: Support missing events in 3.1 spec
Message-ID: <gghrbm3lt5wbjwhjrccmwercuvp6xy43mecqtezhkqznsctj5s@b2ntzbtyfehx>
References: <20240930203445.149954-1-dave@stgolabs.net>
 <20241004124432.00005b67@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241004124432.00005b67@Huawei.com>
User-Agent: NeoMutt/20240425

On Fri, 04 Oct 2024, Jonathan Cameron wrote:\n

>Driver is in perf though so you need to +CC perf maintainers as
>they will probably pick this up directly.

Doing the v3 to add the typo Alison pointed out, I remembered
why I didn't Cc a perf list. Which is it? it is not clear to me
exactly who is responsible to pick this up outside of the cxl
world:

$ ./scripts/get_maintainer.pl 0001-perf-cxlpmu-Support-missing-events-in-3.1-spec.patch
Jonathan Cameron <jonathan.cameron@huawei.com> (maintainer:COMPUTE EXPRESS LINK PMU (CPMU))
Will Deacon <will@kernel.org> (maintainer:ARM PMU PROFILING AND DEBUGGING)
Mark Rutland <mark.rutland@arm.com> (maintainer:ARM PMU PROFILING AND DEBUGGING)
linux-cxl@vger.kernel.org (open list:COMPUTE EXPRESS LINK PMU (CPMU))
linux-arm-kernel@lists.infradead.org (moderated list:ARM PMU PROFILING AND DEBUGGING)
linux-kernel@vger.kernel.org (open list)

... Yeah I guess it's Will and Mark, but arm seems really
misleading and out of place for this. Imo both the cxl driver
and pmu code should have the same maintainer scope.

But even if this does not change, I think the maintainer entries
should at least be labeled something more generic.

Thanks,
Davidlohr
