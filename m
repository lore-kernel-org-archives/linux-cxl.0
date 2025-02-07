Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E1F4A1C;
	Sat,  8 Feb 2025 00:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.249
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738973115; cv=pass; b=RwiWdOE3NIeXygxXwediL1JlF19DCq4eJSpA4tkfQQsK3i/LabyNVtKVw5USWrnKg1AJMkZxIZ9fIjC+3ntTUsLY8iy/5XfBsl5QBQcC5fk2YzZnqLeyEz/uCMjGCuDKyC5k8qkzaYZdoVte7dLGuEXUfF70PA3Xb4HkAzBGuJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738973115; c=relaxed/simple;
	bh=6nIn93xgtbMPZ1IbkvH9U+yB6qf0/CglZ/7Xa5WX9Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHOwkCsPVfLGc+9sAP309jCLfv2XgCIo5Q4ycFGFGwUJSOLLqHh6vVq7hzeKl5PTxqLTKCRmht59/rUE/lHcq2jVLLqKqFa4vtnvuUh0TfDmSooOUZkkqFtLeRef3MWsrgm2WAMBHB2mQ9daaUEtmUEQ8a842S42YCpbneoeO2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=IyQ18xOu; arc=pass smtp.client-ip=23.83.218.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="IyQ18xOu"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 5F1D72C4572;
	Fri,  7 Feb 2025 23:58:03 +0000 (UTC)
Received: from pdx1-sub0-mail-a256.dreamhost.com (trex-6.trex.outbound.svc.cluster.local [100.127.158.245])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id EA3982C410D;
	Fri,  7 Feb 2025 23:58:02 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1738972683; a=rsa-sha256;
	cv=none;
	b=bdQhSzO5qRul2hJ4Ak5M6Gq3XCwOjbr6tlSIh78jjdKCfWo2acYpE5CRj17TR/2l0+nfnN
	f4RWWpNvOCCTySj57BdboMvwMwJzR+/K68uzjPAo9q7wHWlMuYF3UgAMUnnnJtCiU1PGtu
	9J3OaS6PS20k0DauSOqKYZOg0JrVs6LEvBQKK7pXwSPWoit7MJjTponCEk84GQpK77olh8
	5wckuy8VCmqPTc/7Wpx3U2a6Y8YmB8rJsfwgEnVR2Xoujxu3cNQ5KYsKec+BvwQRK9ZdGW
	QySxtnU29P0WjC4dOkWv+knOayuQHlnjPhST3Q/cLTn1EoVS73EgXTaQdqEHCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1738972683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=6nIn93xgtbMPZ1IbkvH9U+yB6qf0/CglZ/7Xa5WX9Es=;
	b=KqCDtiP/K0vWVrXq3esTY6/OOz1mxyMi02izssylGH1USYNAsqIohVLMATxtrWysHdg4ar
	6yue144mpV/ZKvwd8ADWA5kDijtt4rJwH5JOwxEW7u2xTj+7fxo1kPRdVu3iei91jxnsBi
	MYZO/55BStz1vnIyZjtNYW/1mMxmYx7wasPHTVl72h+talB7oH3LmsFupa5qYkFqvLgk9H
	HvTQyRFvy3CmJefui0G4DO5CWnBi5k/ihTHXK5e9CSIC5U54GSP65zTXv5P8bISdNVSQs5
	DnoEH26cOM5FIppAR/7p96s3gszmv4FenvCM8/+Zi0ymRx6O5MWxduNbtE653Q==
ARC-Authentication-Results: i=1;
	rspamd-587f8d7697-hhqps;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Invention-Inform: 3f0ccca42e6f0850_1738972683274_3335836820
X-MC-Loop-Signature: 1738972683274:2535421094
X-MC-Ingress-Time: 1738972683274
Received: from pdx1-sub0-mail-a256.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.127.158.245 (trex/7.0.2);
	Fri, 07 Feb 2025 23:58:03 +0000
Received: from offworld (unknown [172.58.112.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a256.dreamhost.com (Postfix) with ESMTPSA id 4YqWBK5fSzz2W;
	Fri,  7 Feb 2025 15:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1738972682;
	bh=6nIn93xgtbMPZ1IbkvH9U+yB6qf0/CglZ/7Xa5WX9Es=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=IyQ18xOuGA+OGl4fVd9I/sUtfpK9kSBxdZR9RcXr5F4x4Vcpj3tuKZeTMkukZBs8Q
	 vkykugiPCn2JsTPGuCndyKVrSDe8cZkDfl2q8X4bWv3OeP/VPAGAQP/8Aitk7f+c9J
	 X8zX1ZplnFlZt/xCFKxPbUu1jLYOxNRoqYqwam167wWXYuHjROXjdB+Ab0UVPM6wje
	 P+YyRQdFKTd3RaU667/ZCIRS6v1dfo3DrieOyeaMdNM3nYJM9BMdiIIRnqO4OitEr0
	 akuRN1+LvV59Y3EtuHwKv4Ic0gxCXDN+DwHdONI4XUNzF2H392cXMnK97b/LAyegVB
	 lpEM4O/SrNScA==
Date: Fri, 7 Feb 2025 15:57:58 -0800
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
Subject: Re: [PATCH v2 02/18] cxl/pci: Moving code in cxl_hdm_decode_init()
Message-ID: <20250207235758.kczvcogrkkrwmcrn@offworld>
References: <20250207153753.418849-1-rrichter@amd.com>
 <20250207153753.418849-3-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250207153753.418849-3-rrichter@amd.com>
User-Agent: NeoMutt/20220429

On Fri, 07 Feb 2025, Robert Richter wrote:

>Commit 3f9e07531778 ("cxl/pci: simplify the check of mem_enabled in
>cxl_hdm_decode_init()") changed the code flow in this function. The
>root port is determined before a check to leave the function. Since
>the root port is not used by the check it can be moved to run the
>check first. This improves code readability and avoids unnesessary
>code execution.
>
>Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
