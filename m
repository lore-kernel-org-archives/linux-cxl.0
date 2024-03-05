Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641615B661
	for <linux-cxl@vger.kernel.org>; Tue,  5 Mar 2024 16:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655345; cv=none; b=KfAb6xTdfPmJaic5qJnOC81nhYRf1P840ZTz0wF/sBe69QqzSbk1V5bUXLpw4huqu+CwDjD2mykeugwMnlmMGE69FZcUrT6iOA8QWprgKwr9UOkFaDf5zzCWoTn2EAOAEu6gs2b11SmQYRAsNXAPwWrfKX5rxvR65YdnOnRYdD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655345; c=relaxed/simple;
	bh=DGjFJmktwreRT0WPVlKncwEuddKln0GiasqoHGrNohk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxBuzg1YuYimYH6h+PJmCdfNkjfsqHRTz2FVIJoOIXJIEnkuil7j9YwM1tDeXmM/SQ0Ien0kGvu/7aCb4HHYB9e+W/K/P+UrL5GjDqZwnIqBVahYr3eJbIvxKuGZMf6ceKPug4fNA0YSMoK8kCZjR1YeLbzQW7+IN64sI+LtGpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZJc8LaFt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJc8LaFt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709655339;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=0IRcF6LUIzXOc6waplpetng5IJn9Im5YfqBSSYQ/IPk=;
	b=ZJc8LaFtmmfYx5dRl66K76jxye8Rg9Q0qV9q4wDD6e9rFVVFVav51g/Y6sOba0lw7FiZIW
	EHstjlWbr07h0etd4jb3JPtJVTQv8ZSgKMfTYX4Zze9sj6H7/ZoAcBJiew6Cv9hj7y4rs6
	YDDR0gg2D1tqNJvavdTZjSlIjzYiCIQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-gvlUinD6MGuEWgYQUIi7QQ-1; Tue,
 05 Mar 2024 11:15:35 -0500
X-MC-Unique: gvlUinD6MGuEWgYQUIi7QQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E2C229AA3A5;
	Tue,  5 Mar 2024 16:15:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.66])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1EA60C04122;
	Tue,  5 Mar 2024 16:15:32 +0000 (UTC)
Date: Tue, 5 Mar 2024 16:15:30 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	gregory.price@memverge.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com,
	jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 13/13] qapi/cxl.json: Add QMP interfaces to print out
 accepted and pending DC extents
Message-ID: <ZedFIp5gK4aXsqD-@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-14-nifan.cxl@gmail.com>
 <20240305160908.000010c5@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240305160908.000010c5@Huawei.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Tue, Mar 05, 2024 at 04:09:08PM +0000, Jonathan Cameron via wrote:
> On Mon,  4 Mar 2024 11:34:08 -0800
> nifan.cxl@gmail.com wrote:
> 
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > With the change, we add the following two QMP interfaces to print out
> > extents information in the device,
> > 1. cxl-display-accepted-dc-extents: print out the accepted DC extents in
> >    the device;
> > 2. cxl-display-pending-to-add-dc-extents: print out the pending-to-add
> >    DC extents in the device;
> > The output is appended to a file passed to the command and by default
> > it is /tmp/dc-extent.txt.
> Hi Fan,
> 
> Is there precedence for this sort of logging to a file from a qmp
> command?  I can see something like this being useful.

This is pretty unusual.

For runtime debugging information our strong preference is to integrate
'trace' probes throughout the code:

  https://www.qemu.org/docs/master/devel/tracing.html#tracing

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

