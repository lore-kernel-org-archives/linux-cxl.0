Return-Path: <linux-cxl+bounces-1-linux-cxl=archiver.kernel.org@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE7EE92FD1
	for <linux-cxl@archiver.kernel.org>; Fri,  6 Oct 2023 00:37:34 +0000 (UTC)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C9F2828200C
	for <linux-cxl@archiver.kernel.org>; Fri,  6 Oct 2023 00:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186C110E7;
	Fri,  6 Oct 2023 00:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hHFiD6+w"
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8EE629;
	Fri,  6 Oct 2023 00:37:30 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC09D6;
	Thu,  5 Oct 2023 17:37:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A259FC433C8;
	Fri,  6 Oct 2023 00:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696552648;
	bh=Ym/pxMbdvm247vTaNNOcOCuORilqXz04df7lVT2ORUM=;
	h=Date:From:To:Subject:From;
	b=hHFiD6+w7wemeqaHBqdFKYvsPpDYvuGLpN20yNdribuApjnMFlAe5cs8nctev7mbL
	 f1HN7pUZcJ4Habwafh76DhW42Kse6fw3NNHU4y7WpJ74odjK0ZIs1d2TAhIWkLFPo+
	 fD93zYD3uwiY3iEiQXdEXdSvwcLr0eIoKR2l6UB0=
Date: Thu, 5 Oct 2023 20:37:27 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: linux-cxl@vger.kernel.org, devicetree-spec@vger.kernel.org, 
	devicetree-compiler@vger.kernel.org
Subject: This list is being migrated to new infrastructure
Message-ID: <20231005-eating-resent-b5bff1@meerkat>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello, all:

This list is being migrated to the new vger infrastructure. This should be a
fully transparent process and you don't need to change anything about how you
participate with the list or how you receive mail.

There will be a brief delay with archives on lore.kernel.org. I will follow up
once the archive migration has been completed.

Best regards,
Konstantin

