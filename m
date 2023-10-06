Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3871111F;
	Fri,  6 Oct 2023 01:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x58pH+s4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5E8C433C8;
	Fri,  6 Oct 2023 01:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696556166;
	bh=kUILtAnOIK5Ki7AJDwN/LQGE2upqevkXUll5FjrV0cQ=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=x58pH+s43qMnsAZou0LSIBkAllA3g945wqrKZXzYA2nlmCKU83FV4ZPdliH/M6xvQ
	 +xFf/lROVz1iN5GZoqVmglzzUGhnDJ4/BsdoIbZEtt7IbaX6oWfyy4hQ4D5wIdSf3U
	 VVvTxUGr+uEz11Ne0l0CMFY7qpiGUZ/Ya+zhDp5A=
Date: Thu, 5 Oct 2023 21:36:04 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: linux-cxl@vger.kernel.org, devicetree-spec@vger.kernel.org, 
	devicetree-compiler@vger.kernel.org
Subject: Re: This list is being migrated to new infrastructure
Message-ID: <20231005-cleft-watch-054a59@meerkat>
References: <20231005-eating-resent-b5bff1@meerkat>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231005-eating-resent-b5bff1@meerkat>

On Thu, Oct 05, 2023 at 08:37:27PM -0400, Konstantin Ryabitsev wrote:
> Hello, all:
> 
> This list is being migrated to the new vger infrastructure. This should be a
> fully transparent process and you don't need to change anything about how you
> participate with the list or how you receive mail.
> 
> There will be a brief delay with archives on lore.kernel.org. I will follow up
> once the archive migration has been completed.

This work should be completed now.
Please report any issues to helpdesk@kernel.org.

-K
