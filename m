Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0884449C
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 22:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="lX7zzQql"
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2DABE
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 15:10:36 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 80CA4C10E6;
	Fri,  6 Oct 2023 22:10:32 +0000 (UTC)
Received: from pdx1-sub0-mail-a290.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1F9F1C091A;
	Fri,  6 Oct 2023 22:10:32 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1696630232; a=rsa-sha256;
	cv=none;
	b=E7EgE8T/8dPh5f6QXiwh7YBTVAyYJZaOK1/SvsPAAp73wSYo9h/Tqjg4FAYx2Z2pwa5UvH
	Rm6qpxyHeQnhRswwSlIckuB3/bvjOR4WD8B4HLnJdDisWs8n3phIW98tjXMFiYE/04EAPm
	ZRMOheopxWLhdqZ/v3Kmkek8WwAUW0zaiNwMSB3ZOnFN71WySC4RetOb1KhkWEsS2o2kuK
	izA0xE+zH0qXbl6GdPqKhYpbvMM75GAOKCC8tYm+3pLE2DNZmfEBCpF7i2Dgd17Zbc4sn9
	UY9Cy43VskCgCcSSrZZLQd+pkgLZG75/Aq5/LN4jy19aNq/XKWAc2t6XtB0R0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1696630232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=klNi6rwiJ9TnHbIsGh8XW6RvFSeZufeUWjp8Kf1Cdc0=;
	b=bembQ769+VurwJYp+glmYSg9k2hRn32NKW4XXVD3nPAhYRvwH5vACyS3MuCHi88D1gLDK3
	beiGQuI9GwNMogIdKwQJ8EfcIxZ16cRpQ1nPNxp1FCrRO2nKwNvnjnXnf7YK6JNAXetnLr
	388i6sZqgTyq1Pd55R/+QcYLDPpjVnKBPXOnOEcaqoq0XNcZJRDxYpPShU/ymEVuXRvMCG
	SKLHsRUHfnwug+z/N26VRSE6jd7jlB9WhX4aakGsZa8QpulmIm1xgmKQ8OGZukQdcOWfoR
	koTJyYgF8Zm1vywG5PCh9Hm06os05/sflboffOUoMP30vNZNkEyM/Zin7AEXBQ==
ARC-Authentication-Results: i=1;
	rspamd-7d5dc8fd68-lrxvg;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Inform-Skirt: 127a35461ca20a96_1696630232350_2192161936
X-MC-Loop-Signature: 1696630232350:2987624772
X-MC-Ingress-Time: 1696630232349
Received: from pdx1-sub0-mail-a290.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.109.140.247 (trex/6.9.1);
	Fri, 06 Oct 2023 22:10:32 +0000
Received: from offworld (47-158-7-114.lsan.ca.frontiernet.net [47.158.7.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a290.dreamhost.com (Postfix) with ESMTPSA id 4S2N0R57lzz2J;
	Fri,  6 Oct 2023 15:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1696630231;
	bh=klNi6rwiJ9TnHbIsGh8XW6RvFSeZufeUWjp8Kf1Cdc0=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=lX7zzQqlj2lzZfsRk0uXMb794XWcVYIh4oSeQGcro5BYUuuWjglPvvH1BnWfv1gI1
	 swdBSFRrdF42A/FMUTyqDVFk60a//2G+YQDNh9Ci4rynp8H8Q9YlODC0GWnSuNV/jy
	 xDd9mxCOAuCDIi34kmHX70/GDFr1rSid3xGoJGs0kexKwm/5NYvq7ZQTmzlETCkr5N
	 2oYJ2zqNwmenMGzho8EBHtUOjNipTejlEQH3dbMDMr6nuOTTEBjBaqcd5z/TYbj5am
	 xW+J9o539DGdehlgxOhOODMdHXokJofomDMLGNlhQw0KjU+IB2PVar8Epgiq7Z2YPB
	 m64/jmSvmaEaw==
Date: Fri, 6 Oct 2023 15:10:28 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 04/10] cxl/pci: Remove inconsistent usage of
 dev_err_probe()
Message-ID: <zotphaprabwbg3kitexjzvmlhu6bi5gudwsld42fqc75rs3miq@mqgq2mnzcbls>
References: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
 <169657718224.1491153.11083952431204965077.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <169657718224.1491153.11083952431204965077.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 06 Oct 2023, Dan Williams wrote:

>If dev_err_probe() is to be used it should at least be used consistently
>within the same function. It is also worth questioning whether
>every potential -ENOMEM needs an explicit error message.
>
>Remove the cxl_setup_fw_upload() error prints for what are rare /
>hardware-independent failures.
>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
