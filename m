Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127C233555B;
	Wed, 14 Jan 2026 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414929; cv=none; b=chloHLiKP6eqo3pi6c3TBoDQZbXayJuY3XIytUmagiUJ62DIFA7LgB7W0SSvdmSYHXLekMf2+mfHF/27Fx0SnmZ2VO5MAoNfFlYAeGh/15NYmpnTkq4mJBF6MXEbruG72IFzZ4IIh9EvxebmpZS88ZeWYyz5gDXO8KnONhxo8p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414929; c=relaxed/simple;
	bh=RqbxFG78DFsBDAjTXIhotWIF3S+IpPPsq9wACqUIUts=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PanEUlEiEth7AFxnFIG4nlOIdgTgQm9OwV2jTzgQ0m877lR9TG8nRkdkfLPGbW785JzKeooYr1GESERZCzNgHqjYQn8uRh3YE1EN9O/yCoYy4DRYefHWEgzmfpO0T43NSfEKfNx8XuaS911UkDkcBTaB+RpjSbY3Wf87dswqEzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4drvZw50kKzHnGdd;
	Thu, 15 Jan 2026 02:21:44 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 1ACAE40539;
	Thu, 15 Jan 2026 02:22:05 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 14 Jan
 2026 18:22:04 +0000
Date: Wed, 14 Jan 2026 18:22:03 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v9 13/13] cxl: Disable HPA/SPA translation handlers for
 Normalized Addressing
Message-ID: <20260114182203.000061af@huawei.com>
In-Reply-To: <20260110114705.681676-14-rrichter@amd.com>
References: <20260110114705.681676-1-rrichter@amd.com>
	<20260110114705.681676-14-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Sat, 10 Jan 2026 12:46:58 +0100
Robert Richter <rrichter@amd.com> wrote:

> The root decoder provides the callbacks hpa_to_spa and spa_to_hpa to
> perform Host Physical Address (HPA) and System Physical Address
> translations, respectively. The callbacks are required to convert
> addresses when HPA != SPA. XOR interleaving depends on this mechanism,
> and the necessary handlers are implemented.
> 
> The translation handlers are used for poison injection
> (trace_cxl_poison, cxl_poison_inject_fops) and error handling
> (cxl_event_trace_record).
> 
> In AMD Zen5 systems with Normalized Addressing, endpoint addresses are
> not SPAs, and translation handlers are required for these features to
> function correctly.
> 
> Now, as ACPI PRM translation could be expensive in tracing or error
> handling code paths, do not yet enable translations to avoid its
> intensive use. Instead, disable those features which are used only for
> debugging and enhanced logging.
> 
> Introduce the flag CXL_REGION_F_NORM_ADDR that indicates Normalized
> Addressing for a region and use it to disable poison injection and DPA
> to HPA conversion.
> 
> Note: Dropped unused CXL_DECODER_F_MASK macro.

Meh, ideally that would be a precusor patch that Dave could pick up immediately.

Hopefully the whole thing merges though and so we don't have to care
about that.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
