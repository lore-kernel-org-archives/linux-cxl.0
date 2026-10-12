Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE6249B468
	for <linux-cxl@vger.kernel.org>; Mon, 12 Oct 2026 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817940; cv=none; b=QARjUk8UkNDltTOjK8xKuGYmEhJ552fuJDqbsQTPZ2lq7gdm9yiTJk4utIugbG6qyRtPDP7XOScL8iqPfO3PdZVxcYYhIwgpFAQfydDnwYGtjIjDu7KhV8g7CYEXhJ8C8vosRitelIKy20LBuL98fG9V76RjzIQnNR4s9yiRjPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817940; c=relaxed/simple;
	bh=8f3EGukMfR/71U0O1xZg+J7KqcYNua3rboHdKi1ZLhE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JlHPNKBhfB3ROacIIzN6DSt0D48lRR1aDHOu3AzR4uF2j15Cw8CNB6WrvnWJjEjx+xD+LGyv5COsPv3zr6hm/RIkq/FNsg/IBYyQVMN3VPM3HimPI4hmCIHT0A8PHJ2aMJkMzQd54vHb2pg1VZ7E9IalmT+MOLy8iVPCeakK0fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwlEIFZ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwlEIFZ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBF21F0089C;
	Mon, 12 Oct 2026 15:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791817939;
	bh=/vrrbvBGA0Z8PsYuMJcjNBBD+j3Ft3Ky+sw6VkvWg9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QwlEIFZ/CkpAKaDwuEkmkiewMTUTJCy8Q7OXu1CZh1KPl8pT4ydFAadyRhAMnugDJ
	 z5R+4rOryBcd+xIhvXxyWA7WQC7DJSQTUx0Ek9Yj/hlWxRviJkjoyL/t4c69z74LNt
	 5yA9jToUcWK0RZd32MlxHadzpZASToiU9fG3cwHtJDCxK69X9cgNg04J10Xa7sC4p9
	 ICuVDF44hiprhhIt0IdCrzpeI0jcyNnGRnM5+k9eIMimcZy5ZyUBW0LwVKSKAoboty
	 U3M7p+KdNM+WzRHUHFKJKwW6BemDKXmBrP9oalaIqo9XorBQdmwwD88kLIHHDCkKjN
	 Rg+v9joAOuUNw==
Date: Mon, 12 Oct 2026 16:12:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li
 Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>, Robert
 Richter <rrichter@amd.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 3/8] cxl/region: Rename cxl_port_setup_targets() to
 cxl_switch_port_setup_targets()
Message-ID: <20261012161211.4e389052@jic23-hlaptop>
In-Reply-To: <6bef106f136e813b760fa7ab65d419fa4a1b6922.1791676454.git.alison.schofield@intel.com>
References: <cover.1791676454.git.alison.schofield@intel.com>
	<6bef106f136e813b760fa7ab65d419fa4a1b6922.1791676454.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Oct 2026 17:20:18 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> cxl_port_setup_targets() configures the switch decoder targets for a
> region. It runs for each switch port, including host bridges, between the
> root and an endpoint.
> 
> Rename the function to cxl_switch_port_setup_targets() to make its scope
> explicit.
> 
> No functional change.
> 
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Assisted-by: LLM
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
