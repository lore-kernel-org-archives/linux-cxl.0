Received: from siberian.tulip.relay.mailchannels.net (siberian.tulip.relay.mailchannels.net [23.83.218.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02FA1C6FED;
	Fri,  7 Feb 2025 23:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738972618; cv=pass; b=ElJih/K7+KOSsn2j49MYp67jWEro4ljWUcHmZXUb9AqBu7H1LcuPD52FmND+aLWggWoV75aeDqWNJB99r+rEsiqvSAfASNlzKOeyF308M6zga44ieWuUxSjS8Lmistry4QIf+iWPODvrz3XSbw2JvjQUigPpVZGOzkwRp4ch3yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738972618; c=relaxed/simple;
	bh=xjU2AoaATGbbGSjUdwSZk4LtHMEWHvAyBIlKDio5h3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z981z+VNmz4PBlWgxu04WsVPhfd6q66sTBzoAcQt2Sz0+e2sfLy908Y+LIcgSy/ezI65vYZ8Sc7+CGtGU4fTT88ZbdhaxBJqGsNywjZwH7WFfQxUjzG88TWoufDOl2ZoTj2+7UlBZiC2P87SjD2vBWd1kKFb4fNlmJdzTQ6VOM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=UHRKk8fK; arc=pass smtp.client-ip=23.83.218.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="UHRKk8fK"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 55D9580C67;
	Fri,  7 Feb 2025 23:56:49 +0000 (UTC)
Received: from pdx1-sub0-mail-a256.dreamhost.com (100-125-6-118.trex-nlb.outbound.svc.cluster.local [100.125.6.118])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C2928828DD;
	Fri,  7 Feb 2025 23:56:48 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1738972608; a=rsa-sha256;
	cv=none;
	b=mt1TUUeR7uCh8p/4i4X24dEMdktNlXP9txFbNzIjvDcKu3trAuQ3eMnQCbv4SnRs4GFA8+
	5Ho5IsboCcO8KSBMdKtT7JGwPrYneSPuEk4Af3UnbOMSnfDxFx9FdGZAvC0Kc/a7M2PIzA
	69FBPAqOs9cmurCDcaW9lB3urxNksODMYrYQnX7wA/W85c/Y5JOuVeXC7CjTgrABmucods
	lKYs6jkebrdDrMURsDdPcE16eMoxqPpXM8AtVWUGavy+FBEDTRipvF4zup8C+TIfGAFbQS
	jfYAbJnPowMY3IN+MJFCo5Yz+f6Ki6sj9uR/IMV8MUXB5FHfUjMQX4Ja9LvdfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1738972608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=xjU2AoaATGbbGSjUdwSZk4LtHMEWHvAyBIlKDio5h3g=;
	b=0TzXa9sclK5gftc/0CpYHp5bKfbcmUL6EBY0ZRcYdqEUm49TYpSqV6RCOl2R5gH+scZPrd
	m41ebIhOG7EASr3TDkGe33L31fCROrzLBzAEO+UOyVuumd903DJUrM6ZxDS1RWIdAjAYJl
	DJvZl5rlrwUAmJ/ZLnAkC3YLd77IF9oq7Ey2x8/p8nkPpIoxDP0ovi9oFNWaJSIEWXk1J+
	mshFcZXK1pHqstddOMh9KrNxzVMVnyY6GuPMTjIZmAMA25QafsyHaSCaFCLQyRtBvta3HU
	TaldSwycVgSEzciXXcTMYNxErDuox2py/vzy/ksKhQsJMm0WrewZchQBs6wv7A==
ARC-Authentication-Results: i=1;
	rspamd-68c88d6cff-rsb5v;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Quick-Snatch: 6706618518ad465d_1738972609100_1136860145
X-MC-Loop-Signature: 1738972609100:3282361098
X-MC-Ingress-Time: 1738972609100
Received: from pdx1-sub0-mail-a256.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.125.6.118 (trex/7.0.2);
	Fri, 07 Feb 2025 23:56:49 +0000
Received: from offworld (unknown [172.58.112.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a256.dreamhost.com (Postfix) with ESMTPSA id 4YqW8v5RmQz9C;
	Fri,  7 Feb 2025 15:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1738972608;
	bh=xjU2AoaATGbbGSjUdwSZk4LtHMEWHvAyBIlKDio5h3g=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=UHRKk8fKCqoNxaZWb3s6gEoAOyGhYR9D4FCwkOUy5mbMDc1LCf+S/HMszDA3wPmMN
	 6kjvpr7hHhfp7GOPNYPev63aDIvBXCG70L7m2gx62+6eHUPTQ5hEErDNKjatl1ExuZ
	 XfKuYGv3jSeUOv/BuJA8oT9nH8PPrpLsDe71sSJeUujoLIRUZN0PjIjL+r8StB61A0
	 L+Mu55TEL0TxgCPUZUtAGd8By5F4hHSPSqdOPLph8YZFUYIn0APEDgexYGJyOPS0j0
	 DJ23Yr3cOWKnw9PYGcE14OR5bsi8HiTPlf4C/9oytDveHShGqJ8dISkXEGT1n8ofMd
	 FpB8KOsQOzoEQ==
Date: Fri, 7 Feb 2025 15:56:44 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v2 01/18] cxl: Remove else after return
Message-ID: <20250207235644.bdocx2kwegy2stdo@offworld>
References: <20250207153753.418849-1-rrichter@amd.com>
 <20250207153753.418849-2-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250207153753.418849-2-rrichter@amd.com>
User-Agent: NeoMutt/20220429

On Fri, 07 Feb 2025, Robert Richter wrote:

>Remove unnecessary 'else' after return. Improves readability of code.
>It is easier to place comments. Check and fix all occurrences under
>drivers/cxl/.
>
>Signed-off-by: Robert Richter <rrichter@amd.com>
>Reviewed-by: Gregory Price <gourry@gourry.net>
>Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
