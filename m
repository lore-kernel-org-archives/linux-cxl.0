Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D2D2749CA
	for <linux-cxl@vger.kernel.org>; Fri,  8 Aug 2025 10:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754649478; cv=none; b=DhrFaCszYM2F8YVkWek5cM/Kb0fTTdx7TtLZznKZAqA6v0i80eGZslLvEXwwN18WwlryTIqLoFiEAAMft27oXuvg7D2oLPbzhEM+Ma4+VdQ1NdXxGU0WPMrtFNilj34b8hVakAwINFSi6SdBmP/FRxLiXCXWbLuM5y0avIlW0+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754649478; c=relaxed/simple;
	bh=0ACYi7lcD881wXOnSQ0hFpPOOM+/6NfkZImGwIlWJWA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ojRzLuzcwn/eG2D1poTm8cxNG/3rNWXHYlDidpWm11Mp/GySW39Le0PXwioaz9WCojwOBkVV0gvOgRI3QXk6ZU77DCqmABfFRUJRPark0z4XOddU7WvZHK2+W11XM8F6GKmycJ8qP/PIX30/L+FMpWBt0iSIHS1rS8KWdEl1ERo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gz+J4Nty; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gz+J4Nty"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754649475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kHExNf0ah0BKIunxTZU44AuEdhNit8xZe6EZrF8kR+0=;
	b=Gz+J4NtyR6ZBgJjle7kLQ9rxUTfmYVv48s6C+dupAjuff+tMQ3XHUDvgSAny5R+Kkslmbl
	brrA7k60umO/a/FhNEtbcITA56iGoLV16relPF+kHetCGxRZkxoS/xsZ+ovbAWHZ38F6Dg
	zqk0n6Kr5F4Zsc2WP84GU8sexWeWvso=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-baYZLkOTMf2kNv8mwnzNYw-1; Fri,
 08 Aug 2025 06:37:53 -0400
X-MC-Unique: baYZLkOTMf2kNv8mwnzNYw-1
X-Mimecast-MFC-AGG-ID: baYZLkOTMf2kNv8mwnzNYw_1754649472
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B23C1800286;
	Fri,  8 Aug 2025 10:37:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A7FC1954185;
	Fri,  8 Aug 2025 10:37:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 7243421E6A27; Fri, 08 Aug 2025 12:37:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: <shiju.jose@huawei.com>
Cc: <qemu-devel@nongnu.org>,  <linux-cxl@vger.kernel.org>,
  <jonathan.cameron@huawei.com>,  <dave@stgolabs.net>,
  <linuxarm@huawei.com>
Subject: Re: [PATCH v5 1/7] hw/cxl/events: Update for rev3.2 common event
 record format
In-Reply-To: <20250807154346.2209-2-shiju.jose@huawei.com> (shiju jose's
	message of "Thu, 7 Aug 2025 16:43:40 +0100")
References: <20250807154346.2209-1-shiju.jose@huawei.com>
	<20250807154346.2209-2-shiju.jose@huawei.com>
Date: Fri, 08 Aug 2025 12:37:47 +0200
Message-ID: <87ldnuhzes.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

<shiju.jose@huawei.com> writes:

> From: Shiju Jose <shiju.jose@huawei.com>
>
> CXL spec 3.2 section 8.2.9.2.1 Table 8-55, Common Event Record
> format has updated with optional Maintenance Operation Subclass,
> LD ID and ID of the device head information.
>
> Add updates for the above optional parameters in the related
> CXL events reporting and in the QMP commands to inject CXL events.
>
> In qapi/cxl.json added fields of Common Event Record to a common
> structure CXLCommonEventBase.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Please split this patch for easier review:

1. CXLCommonEventBase.  Pure refactoring.

2. Add new members.

