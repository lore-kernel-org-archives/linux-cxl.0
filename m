Received: from cyan.ash.relay.mailchannels.net (cyan.ash.relay.mailchannels.net [23.83.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19BE48FF78
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 18:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789582236; cv=none; b=OnGeKLt8Usx/UcTOVO+/wQWCEbeMQ7GLI4Mxaqk0qqqIMlmvWEIuH9ybapPaWR8Znu/SVv7jzMyLlhshtyNlRV7te9cZrFNZNzHZo3w4n/mn4wdwd6OBsmDQnahZpUXac9amZnWeTmRu7Uhp+bJGdyMsfhVcTj4Jbu5vUJ1JTzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789582236; c=relaxed/simple;
	bh=WwmR/1JyZ5wYhoOcstTJioD/QX379F+o8JPB5UqFN54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mq8nneWLr7w8JrUCJCdd1Cm5sZMNRNSSBhZQUX/GTBPdPxQ+9j2FGEs3lmekrHrwpCkQC2IRwy9Kv4GNeoKArzjUMMHmBziPFFaUHluVDcD8VyfnGhyoHvoiVb/5Ie5tAt8HkCQqwABOLpedLciuH6233O8MWlA26e2AIgpPzd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=FUi2x9Ad; arc=none smtp.client-ip=23.83.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="FUi2x9Ad"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 57DE83E0A00;
	Wed, 16 Sep 2026 18:10:12 +0000 (UTC)
Received: from pdx1-sub0-mail-a241.dreamhost.com (100-100-63-247.trex-nlb.outbound.svc.cluster.local [100.100.63.247])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 059423E1C07;
	Wed, 16 Sep 2026 18:10:12 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Spot-Descriptive: 7cf01e392f7eba73_1789582212107_1018036959
X-MC-Loop-Signature: 1789582212107:1133484260
X-MC-Ingress-Time: 1789582212107
Received: from pdx1-sub0-mail-a241.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.100.63.247 (trex/8.0.2);
	Wed, 16 Sep 2026 18:10:12 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a241.dreamhost.com (Postfix) with ESMTPSA id 4hlRkW2fbdzymR;
	Wed, 16 Sep 2026 11:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1789582211;
	bh=UKEDauU38EGd66j7KdvW0WC+MPiZqxRqx7wIHafM5Gs=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=FUi2x9AdBkEoiBN+441+1eyI+3ZLTQ+GYX2QCAsMMVoaTjsOwbmbUSLWNg0JXA3PC
	 v4uSaFns9rycqxeCAaGmNAQS6xhKflFHQWXDGW57OQHaknQH//TgXQvkLc4a+iUPFu
	 y7ONLlo5w6WfY2UdfFw10EKVdcHjL68uJMNQcgrfASJR0P3eWIOdAYoJLYpG+lQpJf
	 fJt1L3ofyZrnPmxR8vuJ3FDjlE4Sozer1ZC4ZmgSY+ScPXk3yHiEB89P3/9I4ZYi2u
	 53iaIyOlRsPKzthm3yglLTber76Xjjcb6whwM8WytENnOYd6UBIFC9C2wSjSuWVw5p
	 hgWtkFOundwuw==
Date: Wed, 16 Sep 2026 11:10:08 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Li Ming <ming.li@zohomail.com>
Cc: dave.jiang@intel.com, jic23@kernel.org, alison.schofield@intel.com,
	icheng@nvidia.com, benjamin.cheatham@amd.com, alucerop@amd.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v8 08/10] cxl: Allow auto-committed BI hdm decoders
Message-ID: <20260916181008.ymxq7c7yppujikki@offworld>
References: <20260909170302.1550680-1-dave@stgolabs.net>
 <20260909170302.1550680-9-dave@stgolabs.net>
 <642c16ad-e46a-4232-bba1-35a56bcff7b5@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <642c16ad-e46a-4232-bba1-35a56bcff7b5@zohomail.com>
User-Agent: NeoMutt/20220429

On Thu, 10 Sep 2026, Li Ming wrote:

>>  static int __cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable,
>>-			       bool direct)
>>+			       bool direct, bool *adopt)
>>  {
>>  	void __iomem *bi = dport->regs.bi_decoder;
>>  	struct cxl_port *port = dport->port;
>>@@ -1140,6 +1163,20 @@ static int __cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable,
>>  		       CXL_BI_DECODER_CTRL_BI_ENABLE;
>>  	value = (ctrl | set) & ~clr;
>>+
>>+	/*
>>+	 * Adopt this level as firmware left it: nothing below it that
>>+	 * firmware did not account for, nothing this driver has routed
>>+	 * through it, the value this walk would write already in place,
>>+	 * and the decoder (and route table) committed.
>>+	 */
>>+	if (*adopt && !dport->nr_bi && value == ctrl &&
>>+	    cxl_bi_decoder_committed(bi) &&
>>+	    (!port->regs.bi_rt || cxl_bi_rt_committed(port->regs.bi_rt)))
>>+		goto done;
>
>May I know why needs to check dport->nr_bi here?

That !dport->nr_bi is such that if another endpoint already went through this level,
the driver may have been the one who programmed it. A level the driver programmed
tells you nothing about what firmware did. So to play it safe, once a level has
anyone on it, no more adopting; later endpoints program and commit it like normal.

>Assume all BI capabilities have been set up by firmware in two 
>bi-capable EPs under a switch case.
>
>After the first EP setup, the root_port->nr_bi is 1. Seems like the BI 
>capability of the root port will be considered that is not configured 
>by firmware during the second EP BI setup?

When the second EP comes up, it will 'adopt' its own dsp, but, yes the
nr_bi==1 at the root port breaks this adoption, having to do the
traditional writel+commit. Except that for root port this is a nop:
the values are equal so no write, and rp does not do commit. If this
were a nested switch scenario, then yes, there would be that commit.
Furthermore,  it also breaks the adoption for the rest of the components
as we iterate up the topology, requiring commits for nesting > 2.

Effectively all EPs come up with BI (unless commit failure, of course).

I have added this scenario to the testing:
https://github.com/davidlohr/cxl-bi-tests/commit/72cf20f676c65bd4569c343444a6f5db36af05ca

Thanks for all the reviewing!

>
>>+	/* firmware did not bring this level up, so nothing above may */
>>+	*adopt = false;
>>+
>>  	if (value != ctrl)
>>  		writel(value, bi + CXL_BI_DECODER_CTRL_OFFSET);
>>@@ -1153,19 +1190,21 @@ static int __cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable,
>>  		}
>>  		return rc;
>>  	}
>>+done:
>>  	dport->nr_bi++;
>>  	return 0;
>>  }
