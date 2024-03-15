Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F1D1773D
	for <linux-cxl@vger.kernel.org>; Fri, 15 Mar 2024 16:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710520110; cv=none; b=sX3nc+KPVxAuu7s01NnlroF4PCrIeSBxLnKhO4VNMosiGVsTEG+uCXg1FeeN+CfkNdeF1W3SKeRW+G3wK+gXCmLRTlkEP7enSIgovX+ap6VoXDq2b8GxYBxKSv4nzbwxeNGke9UFlBlRAn3IW8gF+xgp3QaexUNLtrNYNcexO+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710520110; c=relaxed/simple;
	bh=P45XOQjxdywqtQLUhuNaWKDzl7RomQqtsdnSmsUMCT0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iXhp4Stb/0lUJS3boG2J7Eyud24h/Bu44V3PqNDI9C0zeNznltvYIHaZGVehYCALWjjb4z8VtKqFhH26KhwXEFAccLNud61zrBoI0CTiIYHuBRCBgXhCmBUSfBD/tScOyVgS8BXkJTshcKjZxQVi91WiGDRSd1FFl0vB4mtpyaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06683C433F1;
	Fri, 15 Mar 2024 16:28:28 +0000 (UTC)
Date: Fri, 15 Mar 2024 12:30:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, Dave
 Jiang <dave.jiang@intel.com>, "Vishal Verma" <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/trace: Properly initialize cxl_poison region
 name
Message-ID: <20240315123042.33cb38a9@gandalf.local.home>
In-Reply-To: <65f474bc214eb_aa22294dd@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240314201217.2112644-1-alison.schofield@intel.com>
	<20240314164136.6d10aa28@gandalf.local.home>
	<ZfNmfCmgCs4Nc+EH@aschofie-mobl2>
	<20240314171737.2025ef60@gandalf.local.home>
	<ZfN8AP/KdbsN32l1@aschofie-mobl2>
	<20240315064703.2202cc69@gandalf.local.home>
	<65f474bc214eb_aa22294dd@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Mar 2024 09:18:04 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Acked-by: Dan Williams <dan.j.williams@intel.com>
> 
> ...for you taking the fix through your tree, and yes, please Cc stable
> on it as well.

Thanks, will do!

I'll pull it in and start running my tests on it.

-- Steve
